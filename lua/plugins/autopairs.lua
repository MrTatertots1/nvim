return {
  -- NVIM Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        enable_check_bracket_line = true,
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = "[%'%\"%)%>%]%)%}%,]",
          end_key = "$",
          before_key = "h",
          after_key = "l",
          cursor = "i",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          manual_position = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })
    end
  },
}
