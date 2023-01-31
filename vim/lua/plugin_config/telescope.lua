-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    -- Change Telescope navigation to use n and e for navigation
    mappings = {
      -- Input mode
      i = {
        ['<C-n>'] = actions.move_selection_next,
        ['<C-e>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,

        -- Splits and tabs
        ["<C-h>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
      },
      -- Normal mode
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-e>"] = actions.move_selection_previous,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

