return {
  -- Mini Icons
  {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = { 
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = true,
      invert_tabline = true,
      inverse = true,
      contrast = "",
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = true,
  --   opts = { contrast = "" },
  -- },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
        },
      })
    end,
  },

  -- NVIM Tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("ui.nvimtree")
    end,
  },

}
