-- ========================
-- Key Mappings
-- ========================

local map = vim.keymap.set

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>f", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- -- Telescope
-- map("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- map("n", "<leader>pg", "<cmd>Telescope live_grep<cr>", { desc = "Search text" })
-- map("n", "<leader>pb", "<cmd>Telescope buffers<cr>", { desc = "Open buffers" })
-- map("n", "<leader>ph", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Debugging
map("n", "<F5>", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<Leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<Leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })

-- General
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })

map("i", "<C-j>", "<Left>", { desc = "Move cursor left" })
map("i", "<C-l>", "<Right>", { desc = "Move cursor right" })
map("i", "<C-h>", "<Up>", { desc = "Move cursor up" })
map("i", "<C-k>", "<Down>", { desc = "Move cursor down" })

-- Close buffer
map("n", "<C-q>", ":bdelete<CR>", { desc = "Close buffer" })

-- Close Neovim
map("n", "<leader>q", ":qa!<CR>", { desc = "Quit Neovim" })

-- Folding
local ufo = require("ufo")
-- map("n", "<leader>h", "zc", { desc = "Fold code" })
-- map("n", "<leader>s", "zo", { desc = "Unfold code" })
-- map("n", "<leader>O", "zR", { desc = "Unfold all code" })
-- map("n", "<leader>C", "zM", { desc = "Fold all code" })
-- map("n", "<leader>H", "zC", { desc = "Fold code recursively" })
-- map("n", "<leader>S", "zO", { desc = "Unfold code recursively" })
-- map("n", "<leader>a", "za", { desc = "Toggle fold under cursor" })
map("n", "<leader>a", function() ufo.toggleFolded() end, { desc = "Toggle fold under cursor" })
map("n", "K", function() ufo.peekFoldedLinesUnderCursor() end, { desc = "Peek folded lines under cursor" })
map("n", "<leader>h", "zc", { desc = "Fold code" })
map("n", "<leader>s", "zo", { desc = "Unfold code" })
map("n", "<leader>S", ufo.openAllFolds, { desc = "Unfold all code" })
map("n", "<leader>H", ufo.closeAllFolds, { desc = "Fold all code" })

-- Copy to system clipboard
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

