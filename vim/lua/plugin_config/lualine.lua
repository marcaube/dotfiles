-- Set lualine as statusline
-- See `:help lualine.txt`
-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        -- Show the full path to the current file
        path = 1,
      },
    }
  }
}

