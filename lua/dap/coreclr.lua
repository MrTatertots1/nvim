local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        -- { id = "console", size = 0.5 },
        -- { id = "terminal", size = 0.5 },
      },
      size = 10,
      position = "bottom",
    },
  },
  -- floating = {
  --   max_height = nil,
  --   max_width = nil,
  --   border = "single",
  --   mappings = {
  --     close = { "q", "<Esc>" },
  --   },
  -- },
  -- windows = { indent = 1 },
})

local FILE_BASEPATH = "/bin/Debug/"
local LAUNCH_FILE = "/.neovim/.launch.json"



-- ============================
-- Dynamically pick DLL path
-- ============================
local json = vim.fn.json_decode
local uv = vim.loop

local debug_cache = {}


-- Helper: build project
local function build_root()
  -- vim.notify("Building project in " .. root, vim.log.levels.INFO)

  vim.notify(vim.fn.getcwd(), vim.log.levels.INFO)
  local result = vim.fn.system("dotnet build")
  if vim.v.shell_error ~= 0 then
    -- vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
    error("Build failed:\n" .. result)
  end

  -- vim.notify("Build succeeded", vim.log.levels.INFO)
  return result
end

-- Helper: read JSON safely
local function read_json(path)
  local fd = uv.fs_open(path, "r", 438) -- 438 = 0666 in octal
  if not fd then return nil end

  local stat = uv.fs_fstat(fd)
  if not stat then
    uv.fs_close(fd)
    return nil
  end

  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  if not data then return nil end

  local ok, result = pcall(json, data)
  if ok then return result end
  return nil
end

-- Find DLL dynamically
local function resolve_project_dir(root, project)
  if project == "." then return root end

  return vim.fn.fnamemodify(root .. "/" .. project, ":p")
end

local function find_csproj(project_dir)
  local matches = vim.fn.glob(project_dir .. "/*.csproj", false, true)

  if #matches == 0 then
    error("No .csproj file found in " .. project_dir)
  end

  if #matches > 1 then
    vim.notify("Multiple .csproj files found in " .. project_dir .. ". Using " .. matches[1], vim.log.levels.WARN)
  end

  return matches[1]
end

-- Main program function
local function get_program_and_cwd()
  local root = vim.fn.getcwd()
  local launch_file = root .. LAUNCH_FILE

  -- Always build root
  build_root()

  if vim.fn.filereadable(launch_file) == 1 then
    local config = read_json(launch_file)

    if config and config.project then
      local project_dir = resolve_project_dir(root, config.project)
      local csproj = find_csproj(project_dir)
      local project_name = vim.fn.fnamemodify(csproj, ":t:r")

      local debug_dir = project_dir .. FILE_BASEPATH
      local frameworks = vim.fn.glob(debug_dir .. "*", false, true)
      if #frameworks == 0 then
        error("No Debug frameworks found in " .. debug_dir .. ". Please build the project first.")
      end

      -- Target framework should be the most recently modified
      table.sort(frameworks, function(a, b)
        return vim.fn.getftime(a) > vim.fn.getftime(b)
      end)

      local tfm = vim.fn.fnamemodify(frameworks[1], ":t")
      local dll = debug_dir .. tfm .. "/" .. project_name .. ".dll"

      vim.notify(
        string.format(
          "DAP launch:\nDLL=%s\nCWD=%s",
          dll,
          project_dir
        )
      )

      return dll, project_dir
    end
  end

  -- fallback: root project auto-detect
  local csproj = find_csproj(root)
  local project_name = vim.fn.fnamemodify(csproj, ":t:r")

  local debug_dir = root .. FILE_BASEPATH
  local frameworks = vim.fn.glob(debug_dir .. "*", false, true)
  if #frameworks == 0 then
    error("No Debug frameworks found in " .. debug_dir .. ". Please build the project first.")
  end

  -- Target framework should be the most recently modified
  table.sort(frameworks, function(a, b)
    return vim.fn.getftime(a) > vim.fn.getftime(b)
  end)
  local tfm = vim.fn.fnamemodify(frameworks[1], ":t")
  local dll = debug_dir .. tfm .. "/" .. project_name .. ".dll"

  vim.notify(
    string.format(
      "DAP launch:\nDLL=%s\nCWD=%s",
      dll,
      root
    )
  )

  return dll, root
end

local function get_program_and_cwd_cached()
  if debug_cache.program and debug_cache.cwd then
    return debug_cache.program, debug_cache.cwd
  end

  local dll, cwd = get_program_and_cwd()
  debug_cache.program = dll
  debug_cache.cwd = cwd
  return dll, cwd
end

local function clear_debug_cache()
  debug_cache = {}
end

-- ============================

local netcoredbg_adapter = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

dap.adapters.coreclr = netcoredbg_adapter
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch - NetCoreDbg",
    request = "launch",
    program = function()
      local dll, _ = get_program_and_cwd_cached()
      return dll
    end,
    cwd = function()
      local _, cwd = get_program_and_cwd_cached()
      return cwd
    end,
    stopAtEntry = false,
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
    },

    -- ** Override run behabior: open a neovim terminal and run program
    runInTerminal = function()
      local dll, cwd = get_program_and_cwd_cached()
      -- Open terminal at the bottom
      vim.cmd("botright split | resize 15 | terminal")
      local term_buf = vim.api.nvim_get_current_buf()

      -- Run the program
      vim.fn.chansend(vim.b.terminal_job_id, string.format("dotnet \"%s\"\n", dll))

      -- Return true to prevent DAP from launching externally
    end,

  },
  -- {
  --   type = "coreclr",
  --   request = "attach",
  --   name = "Attach to running console",
  --   processId = function()
  --     return tonumber(vim.fn.input("PID: "))
  --   end,
  -- },
}

-- dap.listeners.before.launch["open_terminal"] = function()
--   vim.cmd("botright split | terminal")
-- end


dap.listeners.before.event_initialized["clear_debug_cache"] = clear_debug_cache

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end

-- Close DAP UI on termination
-- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
-- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
