return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "BufReadPost",
  config = function()
    vim.o.foldcolumn = "0" -- show fold column
    vim.o.foldlevel = 99 -- set high foldlevel to keep all folds open by default
    vim.o.foldlevelstart = 99 -- set high foldlevelstart to keep all folds open when a file is opened
    vim.o.foldenable = true -- enable folding

    local ufo = require("ufo")
    ufo.setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })
  end,

}
