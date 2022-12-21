-- https://github.com/folke/which-key.nvim
vim.opt.timeoutlen = 250

require('which-key').setup {
  -- ignore_missing = true,
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 10, -- spacing between columns
    align = 'center', -- align columns left, center or right
  },
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
