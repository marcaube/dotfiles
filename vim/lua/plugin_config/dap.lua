local dap = require('dap')
local dapui = require('dapui')
local dap_vtext = require('nvim-dap-virtual-text')

-- Show variable values inline as comments while debugging
dap_vtext.setup({ commented = true })

-- Auto open/close UI with debug session
dapui.setup({
  layouts = {
    {
      -- Sidebar: scopes get the most space since that's where local vars live
      position = 'left',
      size = 75,
      elements = {
        { id = 'scopes',      size = 0.55 },
        { id = 'watches',     size = 0.20 },
        { id = 'stacks',      size = 0.15 },
        { id = 'breakpoints', size = 0.10 },
      },
    },
    {
      -- Bottom tray: console large for logs, repl accessible for inspection
      position = 'bottom',
      size = 18,
      elements = {
        { id = 'console', size = 0.65 },
        { id = 'repl',    size = 0.35 },
      },
    },
  },
})
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- Python: detect active uv/venv environment
local function get_python_path()
  local venv = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
  if venv then return venv .. '/bin/python' end
  local local_venv = vim.fn.getcwd() .. '/.venv/bin/python'
  if vim.fn.executable(local_venv) == 1 then return local_venv end
  return vim.fn.exepath('python3')
end
require('dap-python').setup(get_python_path())

local mason_packages = vim.fn.stdpath('data') .. '/mason/packages'

-- Rust: codelldb adapter (install with :MasonInstall codelldb)
local codelldb_path = mason_packages .. '/codelldb'
if vim.fn.isdirectory(codelldb_path) == 1 then
  local ext = codelldb_path .. '/extension/'
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = ext .. 'adapter/codelldb',
      args = { '--port', '${port}' },
    },
  }
  dap.configurations.rust = {{
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }}
end

-- TypeScript/JavaScript: vscode-js-debug adapter (install with :MasonInstall js-debug-adapter)
local js_debug_path = mason_packages .. '/js-debug-adapter'
if vim.fn.isdirectory(js_debug_path) == 1 then
  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path .. '/js-debug/src/dapDebugServer.js', '${port}' },
    },
  }
  for _, lang in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[lang] = {{
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
    }}
  end
end
