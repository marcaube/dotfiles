-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable NvimTree
-- https://github.com/nvim-tree/nvim-tree.lua
require('nvim-tree').setup()

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<cr>', { desc = 'Find File in Explorer' })

-- `I` to show hidden/ignored folders
-- `H` to show dotfiles
-- `R` to refresh the tree
-- `r` to rename a file
-- `d` to delete a file
-- `a` to add a file/directory
-- `-` to go _up_ a directory
