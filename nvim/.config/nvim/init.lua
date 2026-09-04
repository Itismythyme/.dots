-- Leaderkey
vim.g.mapleader = " "

-- Set clipboard default
vim.opt.clipboard = "unnamedplus"

-- Display line numbers
vim.opt.number = true

-- Remove empty line indicators
vim.opt.fillchars:append({ eob = " " })

-- Plugins

vim.pack.add({
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/lervag/vimtex",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/stevearc/oil.nvim",
  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  }
})

-- Includes
require("vimtex")
require("tree")
require("luasnips")
require("oil_conf")
require("minifiles_conf")
