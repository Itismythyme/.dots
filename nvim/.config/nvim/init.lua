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
  -- General Packages QOL
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/kawre/neotab.nvim",

  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },

  -- Orgmode
  "https://github.com/nvim-orgmode/orgmode",
  "https://github.com/nvim-orgmode/org-bullets.nvim",

  -- tex files
  "https://github.com/lervag/vimtex",
})

-- Includes
require("vimtex")
require("tree")
require("minifiles_conf")
require("orgmode").setup(require("orgmodeconf"))
require("org-bullets").setup()
require("neotab").setup(require("neotabconf"))
require("luasnips")
require("nvim-autopairs").setup({})
require("appearances")
