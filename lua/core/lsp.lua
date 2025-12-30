-- ========================
-- Better diagnostics
-- ========================
vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" },
  severity_sort = true,
})

-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ========================
-- Signature help
-- ========================
-- vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" }) -- TODO: fix?

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	buffer = bufnr,
-- 	callback = function()
-- 		-- 1) LSP formatting (OmniSharp)
-- 		vim.lsp.buf.format({ async = false })
-- 		
-- 		-- 2) Re-indent whole file using editorconfig-aware indent
-- 		vim.cmd("normal! gg=G")
-- 	end,
-- })

-- INFO: LSP attach keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Go to definition
    vim.keymap.set("n", "gd", function()
      require("telescope.builtin").lsp_definitions()
    end, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))

    -- Find references
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references()
    end, vim.tbl_extend("force", opts, { desc = "Find References" }))

    -- Go to implementation
    vim.keymap.set("n", "gi", function()
      require("telescope.builtin").lsp_implementations()
    end, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))

    -- Hover documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))

    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))

    -- INFO: Rename symbol | Handled by inc-rename.nvim plugin 

    -- Show diagnostics in float
    vim.keymap.set("n", "gh", function()
      vim.diagnostic.open_float(nil, {
        focus = false,
        border = "rounded",
        source = "always",
        -- header = "",
      })
    end, { desc = "Show diagnostics under cursor" })

  end,


})

-- ========================
-- Setup LSP servers
-- ========================

vim.lsp.config("roslyn", {})
-- vim.lsp.enable("roslyn")
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("dockerls", {})
vim.lsp.config("docker_compose_language_service", {})
-- vim.lsp.config()


vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  }
)

