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

-- Cursor movement (`mnei` instead of `hjkl`)
map({ 'n', 'v' }, 'm', 'h', { desc = 'Move cursor left' })
map({ 'n', 'v' }, 'n', 'j', { desc = 'Move cursor down' })
map({ 'n', 'v' }, 'e', 'k', { desc = 'Move cursor up' })
map({ 'n', 'v' }, 'i', 'l', { desc = 'Move cursor right' })  -- nv to leave operator-pending mode unchanged

-- Now we don't have `mnei` anymore, need to move those keys around without breaking anything else...

-- Insert key (use l instead of i)
map('n', 'l', 'i', { desc = 'Insert at cursor' })
map('n', 'L', 'I', { desc = 'Insert at the beginning of the line' })

-- Remap j to "end of word", has a nice symetry with b
map({ 'n', 'v' }, 'j', 'e', { desc = 'Move to end of word' })

-- Repeat search (use h instead of n)
map('', 'h', 'nzzzv', { desc = 'Repeat search forward' })
map('', 'H', 'Nzzzv', { desc = 'Repeat search backwards' })

-- Unmap a few conflicting keys
map('', 'E', '<Nop>')
map('', 'N', '<Nop>')
map('', '<C-i>', '<Nop>')

-- Faster navigation
map('', 'M', '^', { desc = 'Move to first char of line' })
map('n', 'N', '5j', { desc = 'Move 5 lines down' })
map('n', 'E', '5k', { desc = 'Move 5 lines up' })
map({ 'n', 'v' }, 'I', '$', { desc = 'Move to end of line' })

-- Move selected line / block of text in visual mode
map('v', 'E', ":move '<-2<CR>gv-gv", { desc = 'Move selected line(s) up one line'})
map('v', 'N', ":move '>+1<CR>gv-gv", { desc = 'Move selected line(s) down one line'})

-- Move between splits
map('n', '<leader>wm', '<C-w><Left>', { desc = 'Move to the split on the left' })
map('n', '<leader>wn', '<C-w><Down>', { desc = 'Move to the split below' })
map('n', '<leader>we', '<C-w><Up>', { desc = 'Move to the split above' })
map('n', '<leader>wi', '<C-w><Right>', { desc = 'Move to the split on the right' })

-- Remap to deal with word wrap, treats it as multiple lines when going up/down
map('n', 'e', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'n', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- One less keypress to go into command-mode
map('n', ';', ':', { desc = 'Command mode' })

-- Quickly toggle between files with leader-leader
map('n', '<leader><space>', '<C-^>', { desc = 'Goto previous buffer' })

-- Save file using C-s
map('n', '<C-s>', ':update<cr>', { desc = 'Save/Update current buffer' })

-- Select All using C-a
map('n', '<C-a>', 'ggVG', { desc = 'Select all the buffer content' })

-- Add undo breakpoints after certain characters
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')

-- Make Y copy till the end of the line, to behave more like C and D
map('n', 'Y', 'y$', { desc = 'Yank until the end of the line' })

-- Go to the first caracter on the line with 00, since ^ is hard to type on my kb
map('n', '00', '^', { desc = 'Go to the first char of the line' })

-- Keep screen centered when moving around
map('n', '<C-d>', '<C-d>zz', { desc = 'Move 1/2 screen down' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Move 1/2 screen up' })
map('n', '<C-f>', '<C-f>zz', { desc = 'Move one screen forward' })
map('n', '<C-b>', '<C-b>zz', { desc = 'Move one screen backwards' })
map('n', 'G', 'Gzz', { desc = 'Goto to end of file' })

-- Quick indentation
map('n', '>', '>>', { desc = 'Indent line' })
map('n', '<', '<<', { desc = 'Unindent line' })
map('v', '>', '>gv', { desc = 'Indent line(s)' })
map('v', '<', '<gv', { desc = 'Unindent line(s)' })

-- Add a trailing-comma and come back
map('n', ',,', 'mxA,<esc>`x', { desc = 'Append a trailing comma' })
map('i', ',,', '<esc>mxA,<esc>`xa', { desc = 'Append a trailing comma' })

-- Add a trailing semi-colon and come back (Rust, PHP)
map('n', ';;', 'mxA;<esc>`x', { desc = 'Append a trailing semicolon' })
map('i', ';;', '<esc>mxA;<esc>`xa', { desc = 'Append a trailing semicolon' })
