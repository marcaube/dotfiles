-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable NvimTree
-- https://github.com/nvim-tree/nvim-tree.lua
require('nvim-tree').setup {
  view = {
    mappings = {
      custom_only = true,
      list = {
        -- Custom mappings/overrides go here
        -- See default mappings: https://github.com/nvim-tree/nvim-tree.lua/blob/9e87ee2d6e86f37ff09cb74ec7dcf2ac984a01e9/doc/nvim-tree-lua.txt#L1477

        -- Open file
        { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        { key = "<C-p>",                          action = "preview" },
        { key = "s",                              action = "system_open" },

        -- Splits
        { key = "<C-v>",                          action = "vsplit" },
        { key = "<C-x>",                          action = "split" },

        -- Tree navigation
        { key = "<",                              action = "prev_sibling" },
        { key = ">",                              action = "next_sibling" },
        { key = "P",                              action = "parent_node" },
        { key = "<BS>",                           action = "close_node" },
        { key = "K",                              action = "first_sibling" },
        { key = "J",                              action = "last_sibling" },
        { key = "R",                              action = "refresh" },
        { key = "-",                              action = "dir_up" },
        { key = { "_", "<2-RightMouse>" },        action = "cd" },
        { key = "W",                              action = "collapse_all" },
        { key = "E",                              action = "expand_all" },

        -- Toggle hidden/ignored files
        { key = "I",                              action = "toggle_git_ignored" },
        { key = "H",                              action = "toggle_dotfiles" },

        -- Manipulate files in the tree
        { key = "a",                              action = "create" },
        { key = "d",                              action = "remove" },
        { key = "D",                              action = "trash" },
        { key = "r",                              action = "rename" },
        { key = "<C-r>",                          action = "full_rename" },
        -- { key = "e",                              action = "rename_basename" },
        { key = "x",                              action = "cut" },
        { key = "c",                              action = "copy" },
        { key = "p",                              action = "paste" },
        { key = "y",                              action = "copy_name" },
        { key = "Y",                              action = "copy_path" },
        { key = "gy",                             action = "copy_absolute_path" },

        -- Search and filter
        { key = "f",                              action = "live_filter" },
        { key = "F",                              action = "clear_live_filter" },
        { key = "S",                              action = "search_node" },
      },
    },
  },
}
