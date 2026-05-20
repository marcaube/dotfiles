-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable netrw in favour of nvim-tree (must be set before plugins load)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable unused language-host providers (avoids ~1.8s python3 interpreter
-- search the first time a .py file is opened). DAP/LSP/plugins still work —
-- they spawn interpreters directly, not via these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Allows neovim to access the system clipboard
vim.o.clipboard = 'unnamedplus'

-- General
-- ---------------------------------------------------------------------------
vim.opt.colorcolumn = '80,120,160' -- rulers at 80, 120 and 160 chars
vim.opt.showmode = true -- show the current editor mode in the statusline
vim.opt.relativenumber = true -- makes jumping around a lot easier
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for
vim.opt.scrolloff = 10 -- Keep more context at edge of screen
vim.opt.tw = 120 -- Set the default texwidth to 120 chars for automatic formatting

-- Sensible splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.g.have_nerd_font = true

-- Load project-local .nvim.lua files (Neovim will prompt to trust on first encounter)
vim.o.exrc = true

-- Diagnostics (virtual_text was disabled by default in 0.11)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})
