require("oil").setup({
  default_file_explorer = true,

  view_options = {
    show_hidden = true,
  },

  columns = {
    "icon",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
  desc = "Open parent directory",
})

vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", {
  desc = "Open Oil",
})
