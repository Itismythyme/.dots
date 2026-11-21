#!/usr/bin/env bash

set -u

CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/fzf-apps.tsv"
STAMP="${CACHE}.stamp"
RUNTIME="${XDG_RUNTIME_DIR:-/tmp}"
FIFO="$RUNTIME/fzf-app-launcher-$UID.fifo"
SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"

APP_DIRS=(
    "$HOME/.local/share/applications"
    "$HOME/.local/share/flatpak/exports/share/applications"
    "/usr/local/share/applications"
    "/usr/share/applications"
    "/var/lib/flatpak/exports/share/applications"
    "/var/lib/snapd/desktop/applications"
)

# applications

refresh_cache() {
    mkdir -p "$(dirname "$CACHE")" || return 1

    local tmp
    tmp=$(mktemp "${CACHE}.XXXXXX") || return 1

    if ! python3 - "$tmp" "${APP_DIRS[@]}" <<'PY'
import configparser
import sys
from pathlib import Path

output = Path(sys.argv[1])
bases = [Path(p) for p in sys.argv[2:]]

seen = set()
apps = []

for base in bases:
    if not base.is_dir():
        continue

    for path in base.rglob("*.desktop"):
        desktop_id = str(path.relative_to(base)).replace("/", "-")

        if desktop_id in seen:
            continue

        try:
            cfg = configparser.ConfigParser(
                interpolation=None,
                strict=False
            )
            cfg.read(path, encoding="utf-8")
            entry = cfg["Desktop Entry"]

            if (
                entry.get("Type", "Application") != "Application"
                or entry.getboolean("Hidden", fallback=False)
                or entry.getboolean("NoDisplay", fallback=False)
            ):
                continue

            name = entry.get("Name", "").strip()
            generic = entry.get("GenericName", "").strip()

            if name:
                seen.add(desktop_id)
                apps.append((
                    f"{name} ({generic})" if generic else name,
                    desktop_id
                ))

        except (OSError, KeyError, configparser.Error, ValueError):
            continue

apps.sort(key=lambda x: x[0].casefold())

with output.open("w", encoding="utf-8") as f:
    for name, desktop_id in apps:
        f.write(f"{name}\t{desktop_id}\n")
PY
    then
        rm -f "$tmp"
        return 1
    fi

    mv -f "$tmp" "$CACHE" || {
        rm -f "$tmp"
        return 1
    }

    # Record directory state after a successful rebuild.
    local stamp_tmp
    stamp_tmp=$(mktemp "${STAMP}.XXXXXX") || return 1

    {
        for dir in "${APP_DIRS[@]}"; do
            if [[ -d "$dir" ]]; then
                stat -c '%n %Y %Z' "$dir"
                find "$dir" -type d -printf '%p %T@ %C@\n' 2>/dev/null
            fi
        done
    } > "$stamp_tmp"

    mv -f "$stamp_tmp" "$STAMP"
}

cache_valid() {
    [[ -s "$CACHE" && -f "$STAMP" ]] || return 1

    local current
    current=$(
        for dir in "${APP_DIRS[@]}"; do
            if [[ -d "$dir" ]]; then
                stat -c '%n %Y %Z' "$dir"
                find "$dir" -type d -printf '%p %T@ %C@\n' 2>/dev/null
            fi
        done
    ) || return 1

    cmp -s "$STAMP" <(printf '%s\n' "$current")
}

ensure_cache() {
    cache_valid || refresh_cache
}

# bluetooth

prop() {
    local data="$1" key="$2" line value

    while IFS= read -r line; do
        line="${line#"${line%%[![:space:]]*}"}"

        [[ "$line" == "$key:"* ]] || continue

        value="${line#*:}"
        value="${value#"${value%%[![:space:]]*}"}"
        value="${value%"${value##*[![:space:]]}"}"

        printf '%s' "$value"
        return
    done <<< "$data"
}

bt_wait() {
    printf '\n'
    bluetoothctl "$@"
    printf '\n'
    read -r -p "Press Enter to continue..." _
}

device_menu() {
    local mac="$1" name="$2" info selected action

    while true; do
        info=$(bluetoothctl info "$mac" 2>/dev/null)

        local connected paired trusted
        connected=$(prop "$info" Connected)
        paired=$(prop "$info" Paired)
        trusted=$(prop "$info" Trusted)

        local -a options=()

        if [[ "$connected" == yes ]]; then
            options+=("disconnect	Disconnect")
        else
            options+=("connect	Connect")
        fi

        if [[ "$paired" == yes ]]; then
            options+=("remove	Forget device")
        else
            options+=("pair	Pair device")
        fi

        if [[ "$trusted" == yes ]]; then
            options+=("untrust	Remove trust")
        else
            options+=("trust	Trust device")
        fi

        options+=("info	Device information" "back	Back")

        selected=$(
            printf '%s\n' "${options[@]}" |
                fzf --delimiter=$'\t' --with-nth=2 \
                    --layout=reverse --border --prompt="$name > "
        ) || return

        IFS=$'\t' read -r action _ <<< "$selected"

        case "$action" in
            connect) bt_wait connect "$mac" ;;
            disconnect) bt_wait disconnect "$mac" ;;
            pair)
                bluetoothctl agent on
                bluetoothctl default-agent
                bt_wait pair "$mac"
                ;;
            remove)
                bt_wait remove "$mac"
                return
                ;;
            trust) bt_wait trust "$mac" ;;
            untrust) bt_wait untrust "$mac" ;;
            info)
                printf '%s\n' "$info"
                read -r -p "Press Enter to continue..." _
                ;;
            back) return ;;
        esac
    done
}

bluetooth_menu() {
    local show powered scanning pairable discoverable
    local devices selected kind action label

    while true; do
        show=$(bluetoothctl show 2>/dev/null) || {
            echo "No Bluetooth controller found."
            read -r -p "Press Enter..." _
            return
        }

        powered=$(prop "$show" Powered)
        scanning=$(prop "$show" Discovering)
        pairable=$(prop "$show" Pairable)
        discoverable=$(prop "$show" Discoverable)

        local -a options=()

        options+=(
            "action	Bluetooth: ${powered:-unknown}"
            "action	Scanning: ${scanning:-unknown}"
            "action	Pairable: ${pairable:-unknown}"
            "action	Discoverable: ${discoverable:-unknown}"
            "action	Refresh devices"
            "action	Back"
        )

        if [[ "$powered" == yes ]]; then
            while read -r _ mac name; do
                [[ -n "${mac:-}" ]] || continue

                local info connected paired status
                info=$(bluetoothctl info "$mac" 2>/dev/null)
                connected=$(prop "$info" Connected)
                paired=$(prop "$info" Paired)

                status=""
                [[ "$connected" == yes ]] && status+=" [Connected]"
                [[ "$paired" == yes ]] && status+=" [Paired]"

                options+=("device	$mac	${name:-Unknown}$status")
            done < <(bluetoothctl devices 2>/dev/null)
        fi

        selected=$(
            printf '%s\n' "${options[@]}" |
                fzf --delimiter=$'\t' --with-nth=2.. \
                    --layout=reverse --border --prompt="Bluetooth > "
        ) || return

        IFS=$'\t' read -r kind action label <<< "$selected"

        if [[ "$kind" == device ]]; then
            device_menu "$action" "$label"
            continue
        fi

        case "$action" in
            "Bluetooth: "*)
                if [[ "$powered" == yes ]]; then
                    bt_wait power off
                else
                    bt_wait power on
                fi
                ;;
            "Scanning: "*)
                if [[ "$scanning" == yes ]]; then
                    bt_wait scan off
                else
                    bluetoothctl scan on
                    sleep 5
                    bluetoothctl scan off
                fi
                ;;
            "Pairable: "*)
                if [[ "$pairable" == yes ]]; then
                    bt_wait pairable off
                else
                    bt_wait pairable on
                fi
                ;;
            "Discoverable: "*)
                if [[ "$discoverable" == yes ]]; then
                    bt_wait discoverable off
                else
                    bt_wait discoverable on
                fi
                ;;
            "Refresh devices") ;;
            Back) return ;;
        esac
    done
}

# menus

applications_menu() {
    ensure_cache || return
    [[ -s "$CACHE" ]] || return

    local selected
    selected=$(
        fzf --delimiter=$'\t' --with-nth=1 \
            --layout=reverse --border --prompt="Applications > " \
            < "$CACHE"
    ) || return

    if [[ -n "$selected" ]]; then
        gtk-launch "${selected#*$'\t'}" >/dev/null 2>&1 &
    fi
}

# persistent session

if [[ "${1:-}" == "--session" ]]; then
    while true; do
        mode=""

        IFS= read -r mode < "$FIFO" || continue

        case "$mode" in
            apps) applications_menu ;;
            bluetooth) bluetooth_menu ;;
        esac

        mmsg dispatch minimized >/dev/null 2>&1 || true
    done
fi

# entry point

case "${1:-apps}" in
    --refresh)
        refresh_cache
        exit $?
        ;;
    apps)
        [[ -s "$CACHE" ]] || refresh_cache || exit 1
        mode=apps
        ;;
    bluetooth)
        mode=bluetooth
        ;;
    *)
        printf 'Usage: %s [apps|bluetooth|--refresh]\n' "$0"
        exit 1
        ;;
esac

[[ -p "$FIFO" ]] || mkfifo -m 600 "$FIFO"

printf -v launch 'kitty -1 --listen-on unix:@kitty --class=fzf-popup --title=fzf-popup %q --session' "$SCRIPT"

mmsg dispatch \
    "toggle_named_scratchpad,none,fzf-popup,$launch" || exit 1

printf '%s\n' "$mode" > "$FIFO"
