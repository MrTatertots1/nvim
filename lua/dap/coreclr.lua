local dap = require("dap")

dap.adapters.coreclr = {
  type = "executable",
  command = "/usr/local/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch - NetCoreDbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
    end,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  vim.cmd("botright split | terminal")
end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
