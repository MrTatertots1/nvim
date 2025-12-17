-- ========================
-- Mason + OmniSharp Setup
-- ========================
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "omnisharp" }
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Path to OmniSharp installed by Mason
local omnisharp_path = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp"

if vim.fn.executable(omnisharp_path) ~= 1 then
  vim.notify("OmniSharp executable not found: " .. omnisharp_path, vim.log.levels.ERROR)
  return
end

local omnisharp_cmd = {
  omnisharp_path,
  "--languageserver",
  "--hostPID", tostring(vim.fn.getpid())
}

-- Root directory detection
local function get_root_dir(fname)
  local util = require("lspconfig.util")
  local path = vim.fn.expand(fname or "%:p")
  return util.root_pattern("*.sln", "*.csproj")(path)
    or util.find_git_ancestor(path)
    or vim.loop.cwd()
end

-- Register OmniSharp with Neovim LSP
vim.lsp.config("omnisharp", {
  cmd = omnisharp_cmd,
  capabilities = capabilities,
  filetypes = { "cs" },
  root_dir = get_root_dir,
})

-- ========================
-- Auto-start OmniSharp for C# buffers
-- ========================
local function attach_omnisharp(bufnr)
  -- Check if already attached
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.name == "omnisharp" then return end
  end

  vim.lsp.start({
    name = "omnisharp",
    cmd = omnisharp_cmd,
    root_dir = function()
      return get_root_dir(vim.api.nvim_buf_get_name(bufnr))
    end,
    capabilities = capabilities,
  })
end

-- Attach to new buffers
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  pattern = "*.cs",
  callback = function(args)
    attach_omnisharp(args.buf)
  end,
})

-- Attach to already open buffers at startup
for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_get_option(bufnr, "filetype") == "cs" then
    attach_omnisharp(bufnr)
  end
end

