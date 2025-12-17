return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "VimEnter", -- make it load on startup
    config = function()
      -- Optional: map key to accept suggestion
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { expr = true, silent = true})
    end,
  },

  -- Copilot + nvim-cmp integration
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "github/copilot.vim",
    },
    opts = {},
    config = function()
      -- only require after the plugin is loaded
      local ok, copilot_cmp = pcall(require, "copilot_cmp")
      if ok then
        copilot_cmp.setup(opts)
      else
        vim.notify("copilot-cmp not found", vim.log.levels.WARN)
      end
    end,
  },

  -- -- Optional: Chat interface for Copilot
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = "gh auth token -s 'repo,workflow' --hostname github.com", -- optional if using GH CLI
  --     })
  --   end,
  -- },
}
