-- [[ Setting options ]]
-- See `:help vim.o`

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

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme catppuccin]]

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
