-- Gitsigns
-- See `:help gitsigns.txt`
-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
}


vim.keymap.set({'o', 'x'}, 'ih', '<cmd>Gitsigns select_hunk<cr>', { noremap = true, silent = true })
