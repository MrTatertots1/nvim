return {
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    -- event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
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
}
