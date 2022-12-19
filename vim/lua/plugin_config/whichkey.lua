-- https://github.com/folke/which-key.nvim
vim.opt.timeoutlen = 250

require('which-key').setup {
  -- ignore_missing = true,
}

local wk = require('which-key')

wk.register({
  ['<leader>c'] = { name = '+Code Actions' },
  ['<leader>s'] = { name = '+Search' },
  ['<leader>t'] = { name = '+Test' },
  ['<leader>h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
  -- ['<leader>w'] = { '<cmd>w!<cr>', 'Save' },
  -- ['<leader>c'] = { '<cmd>BufferKill<CR>', 'Close buffer' },
  ['<leader>q'] = { '<cmd>q<cr>', 'Quit' },
  ['<leader>Q'] = { '<cmd>qa!<cr>', 'Quit All' },
  ['<leader>sc'] = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", '[S]earch [C]olorschemes' },
})
