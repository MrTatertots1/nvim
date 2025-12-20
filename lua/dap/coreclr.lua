local dap = require("dap")
local dapui = require("dapui")

local file_basepath = "/bin/Debug/"

local netcoredbg_adapter = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg/net",
  args = { "--interpreter=vscode" },
}

-- dap.adapters.netcoredbg = netcoredbg_adapter -- 
dap.adapters.coreclr = netcoredbg_adapter

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch - NetCoreDbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. file_basepath, "file")
    end,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
  vim.cmd("botright split | terminal")
end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
