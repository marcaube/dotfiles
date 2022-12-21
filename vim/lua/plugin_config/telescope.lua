-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    -- Change Telescope navigation to use j and k for navigation
    -- and n and p for history in both input and normal mode.
    mappings = {
      -- Input mode
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
      },
      -- Normal mode
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

