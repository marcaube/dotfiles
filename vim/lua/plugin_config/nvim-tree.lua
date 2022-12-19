-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable NvimTree
-- https://github.com/nvim-tree/nvim-tree.lua
require('nvim-tree').setup()

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Open File [E]xplorer' })
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<cr>', { desc = 'Find File in Explorer' })

