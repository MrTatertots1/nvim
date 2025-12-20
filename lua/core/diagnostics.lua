require("tiny-inline-diagnostic").setup({
  -- ...
  signs = {
    left = "",
    right = "",
    diag = "●",
    arrow = "    ",
    up_arrow = "    ",
    vertical = " │",
    vertical_end = " └",
  },
  blend = {
    factor = 0.22,
  },
  -- ...
})

-- Trouble setup/keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Problems (Project)" })
vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle buffer.buf=0<cr>",
  { desc = "Problems (Buffer)" })


-- Telescope diagnostics keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>xtx", builtin.diagnostics,
  { desc = "Diagnostics preview (Project)" })
vim.keymap.set("n", "<leader>xtd", function()
  builtin.diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics preview (Buffer)" })

-- Open trouble instead of quickfix
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd("Trouble quickfix")
  end,
})
