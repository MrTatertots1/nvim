return {
  -- LSP and Mason
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "lua-language-server",
        -- "lua_ls",

        "xmlformatter",
        "csharpier",
        "prettier",

        "stylua",
        "bicep-lsp",
        "html-lsp",
        "css-lsp",
        "eslint-lsp",
        "typescript-language-server",
        "json-lsp",
        "rust-analyzer",

        -- C#
        "roslyn",
        -- "rzls",
        -- "csharp-language-server",
        -- "omnisharp",
      }
    }
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      -- NOTE: leave empty to use defaults
      -- Custom configuration here
    }
  },
}
