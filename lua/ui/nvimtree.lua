local api = require("nvim-tree.api")

local function on_attach(bufnr)
  local opts = function(desc)
    return { 
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- apply default mappings first
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings
  -- vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file in last active window"))
  -- vim.keymap.set("n", "<C-t>", api.node.open.edit, opts("Open as new buffer"))
  vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open in horizontal split"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open in vertical split"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  view = { width = 30, side = "left" },
  actions = {
    open_file = {
      window_picker = { enable = false },
      quit_on_open = false,
    },
  },
  filters = { dotfiles = false },
  renderer = {
    icons = {
      show = { git = true, folder = true, file = true, folder_arrow = true },
    },
  },
})
