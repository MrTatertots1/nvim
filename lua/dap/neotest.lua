require("neotest").setup({
  adapters = {
    require("neotest-dotnet")({
      -- Extra arguments to pass to the test adapter
      -- args = {},
      -- The path to the dotnet SDK, if not in $PATH
      -- dotnet_sdk_path = nil,
    }),
  },
})
