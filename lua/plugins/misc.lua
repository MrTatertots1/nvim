return {


  -- Lightbulb Actions
  {
	  "kosayoda/nvim-lightbulb",
	  event = { "LspAttach" },
	  config = function()
		  local lightbulb = require("nvim-lightbulb")
		  lightbulb.setup({
			  autocmd = { enabled = false },  -- disable default autocmd
			  sign = { enabled = true },
			  virtual_text = { enabled = false },
		  })

      -- Safe LspAttach callback
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Only run for clients that are ready
          if client and client.name ~= "null-ls" and client.initialized then
            -- pcall protects against internal errors
            pcall(function()
              require("nvim-lightbulb").update_lightbulb({ bufnr = bufnr })
            end)
          end
        end,
      })

    end,
  },

  -- Symbols Outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>o", "<cmd>SymbolsOutline<CR>", desc = "Symbols Outline" } },
    config = function()
      require("symbols-outline").setup({ position = "right", width = 30 })
    end,
  },

  -- Toggle Term
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<leader>t]],
        direction = "horizontal",
        shade_terminals = true,
        -- restrict the mapping to normal mode only
        insert_mappings = false, -- <- this is key
      })
    end
  },

  -- Auto Comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = true, -- Add space between comment and code
        sticky = true,  -- Keep comment on the same line in insert mode
        ignore = "^$",  -- Ignore blank lines

        toggler = {
          line = "<C-_>", -- toggle comment on current line
          block = "<leader>/" -- toggle block comment (optional)
        },

        opleader = {
          line = "<C-_>",
          block = "<leader>/"
        },

        -- Optional: pre_hook / post_hook if needed
      })
    end
  },

  -- Which key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        plugins = { spelling = true },
        win = { border = "rounded" },
      })
    end,
  },

  -- Smart Splits
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
      local smart_splits = require("smart-splits")
      smart_splits.setup()
      -- Optional keymaps
      vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move to left split" })
      vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move to lower split" })
      vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move to upper split" })
      vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move to right split" })
      vim.keymap.set("n", "<leader>+", smart_splits.resize_up, { desc = "Increase split height" })
      vim.keymap.set("n", "<leader>-", smart_splits.resize_down, { desc = "Decrease split height" })
      vim.keymap.set("n", "<leader>>", smart_splits.resize_right, { desc = "Increase split width" })
      vim.keymap.set("n", "<leader><", smart_splits.resize_left, { desc = "Decrease split width" })
      vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Equalize all splits (vertical + horizontal)" })
      vim.keymap.set("n", "<leader>|", "<C-w>|", { desc = "Equalize all splits (horizontally)" })
      vim.keymap.set("n", "<leader>_", "<C-w>_", { desc = "Equalize all splits (vertically)" })
    end,
  },

  -- Lualine Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
      })
    end,

  },

  -- ! NOT WORKING
  -- -- Null-ls (Linters / Formatters)
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = {"BufReadPre", "BufNewFile" },
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local null_ls = require("null-ls")
  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.formatting.prettier,
  --         null_ls.builtins.diagnostics.eslint,
  --         null_ls.builtins.formatting.stylua,
  --       },
  --     })
  --   end,
  -- },

  -- Incremental Rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<F2>", ":IncRename ", { desc = "Incremental Rename" })
    end,
  },

  -- Better Echo
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#000000",
      })
    end,
  },

  -- Edgy (Sidebar manager)
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("edgy").setup({
        -- default config is fine, customize if needed
        animate = { enabled = true },
      })
    end,
  },


}
