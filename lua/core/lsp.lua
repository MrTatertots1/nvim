-- ========================
-- Better diagnostics
-- ========================
vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" },
  severity_sort = true,
})

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ========================
-- Signature help
-- ========================
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
