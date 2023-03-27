-- Helper function
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map({ 'n', 'v' }, '<Space>', '<Nop>')

-- One less keypress to go into command-mode
map('n', ';', ':', { desc = 'Command mode' })

-- Quickly toggle between files with leader-leader
map('n', '<leader><space>', '<C-^>', { desc = 'Goto previous buffer' })

-- Save file using C-s
map('n', '<C-s>', ':update<cr>', { desc = 'Save/Update current buffer' })

-- Select All using C-a
map('n', '<C-a>', 'ggVG', { desc = 'Select all the buffer content' })

-- Use tab to navigate to matching parens and brackets
-- map('n', '<tab>', '%')
-- map('v', '<tab>', '%')

-- Add undo breakpoints after certain characters
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')

-- Make Y copy till the end of the line, to behave more like C and D
map('n', 'Y', 'y$', { desc = 'Yank until the end of the line' })

-- Go to the first caracter on the line with 00, since ^ is hard to type on my kb
map('n', '00', '^', { desc = 'Go to the first char of the line' })

-- Go to the beginning and EOL with B and E
map('n', 'B', '0')
map('n', 'E', '$')

-- Keep screen centered when moving around
map('n', '<C-d>', '<C-d>zz', { desc = 'Move 1/2 screen down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Move 1/2 screen up' })
map('n', '<C-f>', '<C-f>zz', { desc = 'Move one screen forward' })
map('n', '<C-b>', '<C-b>zz', { desc = 'Move one screen backwards' })
map('n', 'n', 'nzzzv', { desc = 'Next search result' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result' })
map('n', 'G', 'Gzz', { desc = 'Goto to end of file' })

-- Quick indentation
map('n', '>', '>>', { desc = 'Indent line' })
map('n', '<', '<<', { desc = 'Unindent line' })
map('v', '>', '>gv', { desc = 'Indent line(s)' })
map('v', '<', '<gv', { desc = 'Unindent line(s)' })

-- Move between splits
map('n', '<C-h>', '<C-w><Left>')
map('n', '<C-k>', '<C-w><Up>')
map('n', '<C-l>', '<C-w><Right>')
map('n', '<C-j>', '<C-w><Down>')

-- Add a trailing-comma and come back
map('n', ',,', 'mxA,<esc>`x', { desc = 'Append a trailing comma' })
map('i', ',,', '<esc>mxA,<esc>`xa', { desc = 'Append a trailing comma' })

-- Add a trailing semi-colon and come back (Rust, PHP)
map('n', ';;', 'mxA;<esc>`x', { desc = 'Append a trailing semicolon' })
map('i', ';;', '<esc>mxA;<esc>`xa', { desc = 'Append a trailing semicolon' })
