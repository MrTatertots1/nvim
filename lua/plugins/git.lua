return {

  -- TODO: Add octo.nvim for GitHub PR integration
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    config = function()
      require("octo").setup({
        default_remote = { "upstream", "origin" },
        ssh_aliases = {},
      })
    end,
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    -- event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History" },
      { "<leader>gds", "<cmd>DiffviewOpen --staged<cr>", desc = "Diffview Open Staged" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        use_icons = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
      })
    end,
  },

  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        current_line_blame = true,
        current_line_blame_opts = { delay = 500 },

        on_attach = function(bufnr)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end 

          -- Hunk navigation
          map("n", "]c", gs.next_hunk, "Next Git hunk")
          map("n", "[c", gs.prev_hunk, "Previous Git hunk")

          -- Hunk actions
          map("n", "<leader>ghs", gs.stage_hunk, "Stage Git hunk")
          map("n", "<leader>ghr", gs.reset_hunk, "Reset Git hunk")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Git hunk")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage Git hunk")

          -- File actions
          map("n", "<leader>gS", gs.stage_buffer, "Stage Git buffer")
          map("n", "<leader>gR", gs.reset_buffer, "Reset Git buffer")

          -- Blame / diff
          map("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle Git blame")
          map("n", "<leader>gd", gs.diffthis, "Git diff this file")
        end


      })
    end,
  },

  -- Vim-fugitive
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "GStatus" },
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git Status" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git Commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" },
      { "<leader>gl", "<cmd>Git pull<CR>", desc = "Git Pull" },
    }
  },
}
