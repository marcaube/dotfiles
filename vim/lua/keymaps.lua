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


-- Key mappings
-- ---------------------------------------------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- One less keypress to go into command-mode
vim.keymap.set('n', ';', ':', { desc = 'Command mode' })

-- Quickly toggle between files with leader-leader
vim.keymap.set('n', '<leader><space>', '<C-^>', { desc = 'Goto previous buffer' })

-- Save file using C-s
vim.keymap.set('n', '<C-s>', ':update<cr>', { desc = 'Save/Update current buffer' })

-- Select All using C-a
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all the buffer content' })

-- Use tab to navigate to matching parens and brackets
vim.keymap.set('n', '<tab>', '%')
vim.keymap.set('v', '<tab>', '%')

-- Add undo breakpoints after certain characters
-- TODO: fix
-- vim.cmd('inoremap , ,<c-g>u')
-- vim.cmd('inoremap . .<c-g>u')
-- vim.cmd('inoremap ! !<c-g>u')
-- vim.cmd('inoremap ? ?<c-g>u')

-- Make Y copy till the end of the line, to behave more like C and D
vim.keymap.set('n', 'Y', 'y$')

-- Go to the first caracter on the line with 00, since ^ is hard to type on my kb
vim.keymap.set('n', '00', '^')

-- Go to the beginning and EOL with B and E
vim.keymap.set('n', 'B', '0')
vim.keymap.set('n', 'E', '$')

-- Keep screen centered when moving around
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'G', 'Gzz')

-- Quick indentation
vim.keymap.set('n', '>', '>>')
vim.keymap.set('n', '<', '<<')

-- Move between splits
vim.keymap.set('n', '<C-h>', '<C-w><Left>')
vim.keymap.set('n', '<C-k>', '<C-w><Up>')
vim.keymap.set('n', '<C-l>', '<C-w><Right>')
vim.keymap.set('n', '<C-j>', '<C-w><Down>')

-- Add a trailing-comma and come back
-- TODO: fix
-- vim.cmd('nmap ,, mxA,<esc>`x')
-- vim.cmd('imap ,, <esc>mxA,<esc>`xa')

-- Add a trailing semi-colon and come back (Rust, PHP)
-- TODO: fix
-- vim.cmd('nmap ;; mxA;<esc>`x')
-- vim.cmd('imap ; ;') -- There was a clash with an existing mapping
-- vim.cmd('imap ;; <esc>mxA;<esc>`xa')
