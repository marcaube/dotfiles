-- https://github.com/vim-test/vim-test

-- Shortcuts for tests
vim.keymap.set('n', '<leader>tf', '<cmd>:TestFile<cr>', { desc = '[T]est [F]ile'})
vim.keymap.set('n', '<leader>tn', '<cmd>:TestNearest<cr>', { desc = '[T]est [N]earest'})
vim.keymap.set('n', '<leader>tl', '<cmd>:TestLast<cr>', { desc = '[T]est [L]ast'})
vim.keymap.set('n', '<leader>ts', '<cmd>:TestSuite<cr>', { desc = '[T]est [S]uite'})
vim.keymap.set('n', '<leader>tv', '<cmd>:TestVisit<cr>', { desc = '[V]isit last test file'})

