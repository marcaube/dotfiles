local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('gr', function() require('telescope.builtin').lsp_references() end, 'Goto References')
  nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

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

vim.lsp.config('ruff', {
  init_options = { settings = {} },
})

-- See: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        jedi_completion     = { enabled = true },
        jedi_hover          = { enabled = true },
        jedi_references     = { enabled = true },
        jedi_signature_help = { enabled = true },
        jedi_symbols        = { enabled = true, all_scopes = true },
        pycodestyle         = { enabled = false },
        flake8              = { enabled = true, ignore = {}, maxLineLength = 160 },
        pylint              = { enabled = false },
        pydocstyle          = { enabled = false },
        pyflakes            = { enabled = false },
        mccabe              = { enabled = false },
        preload             = { enabled = false },
        rope_completion     = { enabled = true },
        yapf                = { enabled = false },
      },
    },
  },
})

local servers = { 'rust_analyzer', 'pylsp', 'ruff', 'lua_ls', 'ts_ls' }

-- Start servers when matching filetypes are opened
vim.lsp.enable(servers)

-- Mason: ensure server binaries are installed
require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = servers })

require('fidget').setup()
