return {
  { 
    "mfussenegger/nvim-dap",
    lazy = true,
  },

  { 
    "rcarriga/nvim-dap-ui",
    dependencies = { 
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
    --   require("dapui").setup()
      require("dap.coreclr")
    end,
  },

  -- Neotest
  { "nvim-neotest/nvim-nio" },
  {
    "nvim-neotest/neotest",
    requires = { "Issafalcon/neotest-dotnet" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "Issafalcon/neotest-dotnet",
    lazy = false,
    dependencies = { "nvim-neotest/neotest" },
  },
}
