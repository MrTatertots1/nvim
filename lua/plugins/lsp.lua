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
        "xmlformatter",
        "csharpier",
        "prettier",
        "stylua",

        -- C#
        "roslyn",
      },
      automatic_installation = true,
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Core
        "lua_ls",
        "jsonls",
        "html",
        "cssls",
        "eslint",
        "ts_ls",
        "svelte",
        "tailwindcss",
        "rust_analyzer",

        -- Cloud / infra
        -- "bicep",

        -- Docker
        "dockerls",
        "docker_compose_language_service",


      },
      automatic_installation = true,

    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      -- NOTE: leave empty to use defaults
      -- Custom configuration here
    }
  },
}
