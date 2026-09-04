-- Configure nvim-tree
require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- Toggle the file tree with Space + e
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {
  desc = "Toggle file tree",
})

-- Reveal current file in tree
vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>", {
  desc = "Find current file in tree",
})
