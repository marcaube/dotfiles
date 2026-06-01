local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  nmap('gd', function() require('telescope.builtin').lsp_definitions() end, 'Goto Definition')
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  -- Override Neovim 0.11+ defaults (grr/gri/grt) to use telescope picker UI
  nmap('grr', function() require('telescope.builtin').lsp_references() end, 'Goto References')
  nmap('gri', function() require('telescope.builtin').lsp_implementations() end, 'Goto Implementation')
  nmap('grt', function() require('telescope.builtin').lsp_type_definitions() end, 'Goto Type Definition')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Global defaults: applied to every server
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Server-specific overrides
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Ruff handles linting and formatting; let basedpyright own hover/definitions.
-- Per-project type rules go in pyrightconfig.json or pyproject.toml [tool.basedpyright].
vim.lsp.config('ruff', {
  init_options = { settings = {} },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    on_attach(client, bufnr)
  end,
})

vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard',  -- 'off' | 'basic' | 'standard' | 'strict' | 'all'
        autoImportCompletions = true,
        diagnosticMode = 'openFilesOnly',
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
        },
      },
    },
  },
})

local servers = { 'rust_analyzer', 'basedpyright', 'ruff', 'lua_ls', 'ts_ls' }

-- Start servers when matching filetypes are opened
vim.lsp.enable(servers)

-- Inlay hints on by default; <leader>ui toggles. Servers without support are no-ops.
vim.lsp.inlay_hint.enable(true)

-- Format Rust files on save via rust_analyzer (rustfmt).
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rs',
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf })
  end,
  desc = 'Format Rust buffer on save (rustfmt)',
})

-- Mason: ensure server binaries are installed
require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = servers })

require('fidget').setup()
