require("mini.files").setup()

-- Toggle MiniFiles at the current file
local project_dir = "/mnt/backup/Sync/大学/Fall 26/"

vim.keymap.set("n", "<leader>m", function()
  if MiniFiles.close() then
    return
  end

  MiniFiles.open(project_dir)
end, {
  desc = "Toggle Project Files",
})
