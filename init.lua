
-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- Also set the local leader

-- ========================
-- lazy.nvim bootstrap
-- ========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(require("plugins"))

-- ========================
-- Runtime Config
-- ========================
require("ui.colors")
require("lsp.omnisharp")
require("dap.coreclr")

require("core.options")
require("core.utils")
require("core.autocmds")
require("core.lsp")
require("core.keymaps")
