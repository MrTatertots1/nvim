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

  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- event = "VeryLazy",
    config = function()
      require("todo-comments").setup({
          signs = true, -- show icons in the signs column
          sign_priority = 8, -- sign priority
          -- keywords recognized as todo comments
  -- WARN: comments
          keywords = {
            FIX = {
              icon = " ", -- icon used for the sign, and in search results
              color = "error", -- can be a hex color, or a named color (see below)
              alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
              -- signs = false, -- configure signs for some keywords individually
            },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            -- STAR = { icon = "★ ", color = "info", alt = { "\\*" } },
            -- BANG = { icon = " ", color = "error", alt = { "!" } },
          },
          gui_style = {
            fg = "NONE", -- The gui style to use for the fg highlight group.
            bg = "BOLD", -- The gui style to use for the bg highlight group.
          },
          merge_keywords = true, -- when true, custom keywords will be merged with the defaults
          -- highlighting of the line containing the todo comment
          -- * before: highlights before the keyword (typically comment characters)
          -- * keyword: highlights of the keyword
          -- * after: highlights after the keyword (todo text)
          highlight = {
            multiline = true, -- enable multine todo comments
            multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
            multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
            before = "", -- "fg" or "bg" or empty
            keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
            comments_only = false, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
          },
          -- list of named colors where we try to extract the guifg from the
          -- list of highlight groups or use the hex color if hl not found as a fallback
          colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" }
          },
          search = {
            command = "rg",
            args = {
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
          },
      })

      pcall(function()
        require("telescope").load_extension("todo-comments")
      end)

      vim.keymap.set("n", "<leader>nt", "<cmd>TodoTelescope<CR>", { desc = "Next TODO" })
      vim.keymap.set("n", "<leader>lt", "<cmd>TodoTelescope keywords=TODO,FIX,HACK,NOTE,WARN,PERF,TEST<CR>", { desc = "List all TODOs" })
    end,
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install", -- required to install dependencies
    ft = { "markdown" }, -- only load for markdown files
    config = function()
      -- Open preview in browser
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown Preview" })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })
    end,

  },

}
