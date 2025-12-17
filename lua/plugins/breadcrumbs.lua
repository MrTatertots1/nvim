return {
  -- Breadcrumbs
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    event = "LspAttach",
    config = function()
      require("barbecue").setup({ attach_navic = false })
      require("nvim-navic").setup({ highlight = true, separator = " > " })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,
  },
}
