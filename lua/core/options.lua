-- ====================
-- Basic Vim Options
-- ====================

-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set indentation options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Colors & UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Enable mouse support
vim.opt.mouse = "a"

-- Set clipboard to use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Wrapping and scrolling
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- =======================
-- Folding (for nvim-ufo)
-- =======================

-- Use Treesitter folds primarily
vim.o.foldcolumn = "0" -- show fold column
vim.o.foldlevel = 99 -- set high foldlevel to keep all folds open by default
vim.o.foldlevelstart = 99 -- set high foldlevelstart to keep all folds open when a file is opened
vim.o.foldenable = true -- enable Folding
vim.o.foldmethod = "expr" -- use expression for Folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- ufo + Treesitter foldexpr

-- Optional: customize virtual text for folded lines
vim.opt.foldtext = "v:lua.require'ufo'.foldtext()"

