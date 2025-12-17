return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "bin/", "obj/", "%.dll", "%.exe" },
        },
      })
    end,

    keys = {
      {
        "<leader>pf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
        mode = "n",
      },
      {
        "<leader>pg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Search text",
        mode = "n",
      },
      {
        "<leader>pb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Open buffers",
        mode = "n",
      },
      {
        "<leader>ph",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
        mode = "n",
      },
    },
  },
}
