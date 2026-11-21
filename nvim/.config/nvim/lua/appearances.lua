-- lua/appearance.lua

vim.opt.termguicolors = true
vim.cmd.colorscheme("zaibatsu")

-- Filetype detection and syntax highlighting
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Additional filetype associations
vim.filetype.add({
  extension = {
    org = "org",
    md = "markdown",
    markdown = "markdown",
    mdx = "markdown",
    txt = "text",
    rst = "rst",
    tex = "tex",
    bib = "bib",
    jsonc = "jsonc",
    yml = "yaml",
    yaml = "yaml",
    sh = "sh",
    bash = "sh",
    zsh = "zsh",
    fish = "fish",
    py = "python",
    js = "javascript",
    jsx = "javascriptreact",
    ts = "typescript",
    tsx = "typescriptreact",
    html = "html",
    css = "css",
    scss = "scss",
    sass = "sass",
    xml = "xml",
    toml = "toml",
    sql = "sql",
    rs = "rust",
    go = "go",
    c = "c",
    h = "c",
    cpp = "cpp",
    hpp = "cpp",
    java = "java",
    kt = "kotlin",
    php = "php",
    rb = "ruby",
    lua = "lua",
    vim = "vim",
  },
})

-- Empty home screen
vim.opt.shortmess:append("I")

-- Editor layout
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.fillchars = {
  eob = " ",
  vert = "│",
  fold = " ",
}

vim.opt.laststatus = 3
vim.opt.showmode = false

-- AMOLED editor background
local set = vim.api.nvim_set_hl

-- Override backgrounds only, preserving the colorscheme's foreground
-- and syntax highlighting colors.
set(0, "Normal", {
  bg = "#000000",
})

set(0, "NormalFloat", {
  bg = "#000000",
})

set(0, "FloatBorder", {
  fg = "#555555",
  bg = "#000000",
})

set(0, "SignColumn", {
  bg = "#000000",
})

set(0, "LineNr", {
  fg = "#666666",
  bg = "#000000",
})

set(0, "CursorLine", {
  bg = "#101010",
})

set(0, "CursorLineNr", {
  bg = "#101010",
  bold = true,
})

set(0, "Visual", {
  bg = "#303030",
})

set(0, "Search", {
  fg = "#000000",
  bg = "#ffffff",
  bold = true,
})

set(0, "IncSearch", {
  fg = "#000000",
  bg = "#c8c8c8",
  bold = true,
})

set(0, "StatusLine", {
  fg = "#eeeeee",
  bg = "#181818",
})

set(0, "StatusLineNC", {
  fg = "#888888",
  bg = "#0a0a0a",
})

set(0, "WinSeparator", {
  fg = "#333333",
  bg = "#000000",
})

set(0, "Pmenu", {
  fg = "#eeeeee",
  bg = "#151515",
})

set(0, "PmenuSel", {
  fg = "#000000",
  bg = "#eeeeee",
})

-- Powerline-style statusline highlight groups
set(0, "StatusFile", {
  fg = "#ffffff",
  bg = "#303030",
  bold = true,
})

set(0, "StatusInfo", {
  fg = "#eeeeee",
  bg = "#181818",
})

set(0, "StatusSeparator", {
  fg = "#303030",
  bg = "#181818",
})

-- Return a readable name for the current mode
_G.status_mode = function()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
    s = "SELECT",
    t = "TERMINAL",
  }

  local current_mode = vim.fn.mode()
  return modes[current_mode] or current_mode:upper()
end

-- Display the filename in a bar at the top of each window
vim.o.winbar = "%f %m"

-- Display the mode and file information in the bottom statusline
vim.o.statusline =
  "%#StatusFile# %{v:lua.status_mode()} " ..
  "%#StatusSeparator#" ..
  "%#StatusInfo# %y  %{&fenc !=# '' ? &fenc : &enc}  %{&ff}  %l:%c "
