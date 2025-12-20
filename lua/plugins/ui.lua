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
    -- config = true,
    opts = {
      
        contrast = "",
        dim_inactive = true,
        transparent_mode = false,
        terminal_colors = true,

        -- Ocean-style palette
        palette_overrides = {
          dark0         = "#13131C",
          dark1         = "#262630",
          dark2         = "#2E2E3E",
          dark3         = "#363646",
          dark4         = "#3E3E4E",
          light0        = "#ECEFF1",
          light1        = "#D0D0D0",
          bright_red    = "#FF8A65",
          bright_orange = "#FFB74D",
          bright_yellow = "#F0D060",
          bright_green  = "#A5D6A7",
          bright_aqua   = "#4DD0E1",
          bright_blue   = "#80CBC4",
          bright_purple = "#7E57C2",
        },

        overrides = {
          -- Core UI
          Normal       = { fg = "#ECEFF1", bg = "#13131C" },
          Comment      = { fg = "#546E7A", italic = true },
          LineNr       = { fg = "#5C5C5C" },
          CursorLineNr = { fg = "#F0D060", bold = true },

          -- Syntax
          Keyword      = { fg = "#FF8A65", italic = true },
          Function     = { fg = "#7E57C2", bold = true }, -- darker purple
          String       = { fg = "#4DD0E1" },
          Constant     = { fg = "#F0D060" },
          Boolean      = { fg = "#FF8A65", bold = true },
          Number       = { fg = "#F0D060" },
          Operator     = { fg = "#FFB74D" },

          -- Classes, Interfaces, Types
          Class        = { fg = "#FFB74D", bold = true }, -- Vim syntax fallback
          ["@class"]   = { fg = "#FFB74D", bold = true }, -- Treesitter
          ["@type"]    = { fg = "#FFB74D", bold = true }, -- Treesitter
          ["@interface"] = { fg = "#FFB74D", bold = true }, -- Treesitter
          ["@constructor"] = { fg = "#FFB74D", bold = true }, -- often for class instantiation

          -- Optional extras for clarity
          Namespace    = { fg = "#FFB74D" },
          Tag          = { fg = "#FF8A65", bold = true },
          Label        = { fg = "#FFB74D" },
          Property     = { fg = "#80CBC4" },
          Method       = { fg = "#7E57C2", bold = true },

          -- Diagnostics / TODO
          -- Todo         = { fg = "#FFB74D", bold = true },
        },

        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings   = true,
          comments  = true,
          operators = false,
          folds     = true,
          emphasis  = true,
        },
        strikethrough       = true,
        invert_selection    = false,
        invert_signs        = false,
        invert_tabline      = false,
        inverse             = false,
      
    },
  },


  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    version = "*",
    config = function()
      local opts = { noremap = true, silent = true }
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = false,
          enforce_regular_tabs = false, -- allow different number of buffers per split
          view = "multiwindow", -- important: allows splits to show independent buffer tabs
          themable = true,
        },
      })

      -- Cycle buffers in current split
      vim.api.nvim_set_keymap("n", "<S-n>", "<cmd>BufferLineCycleNext<CR>", opts)
      vim.api.nvim_set_keymap("n", "<S-p>", "<cmd>BufferLineCyclePrev<CR>", opts)

      -- Pick a buffer in current split
      vim.api.nvim_set_keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)

      -- Close current buffer in current split
      vim.api.nvim_set_keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", opts)

      -- Open a new buffer in current split
      vim.api.nvim_set_keymap("n", "<leader>bn", "<cmd>enew<CR>", opts)
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
