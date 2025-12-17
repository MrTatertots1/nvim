return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "bin/", "obj/", "%.dll", "%.exe" },
          mappings = {
            i = {
              -- Picker Navigation
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              -- Scroll Previewer
              ["<PageDown>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.preview_scrolling_up,
            },
            n = {
              -- Picker Navigation
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              -- Scroll Previewer
              ["<PageDown>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.preview_scrolling_up,
            },
          }
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
