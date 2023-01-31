-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable NvimTree
-- https://github.com/nvim-tree/nvim-tree.lua
require('nvim-tree').setup {
  view = {
    mappings = {
      custom_only = false,
      list = {
        -- Custom mappings/overrides go here
        { key = "e", action = "", action_cb = "" },
        { key = "E", action = "", action_cb = "" },
        { key = "<C-i>", action = "", action_cb = "" },
      },
    },
  },
}

-- vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<cr>', { desc = 'Find File in Explorer' })

-- `I` to show hidden/ignored folders
-- `H` to show dotfiles
-- `R` to refresh the tree
-- `r` to rename a file
-- `d` to delete a file
-- `a` to add a file/directory
-- `-` to go _up_ a directory
