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
      require("dapui").setup()
      require("dap.coreclr")
    end,
  },
}
