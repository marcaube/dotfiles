-- Navigate between nvim and tmux panes the same as with nvim splits
-- https://github.com/christoomey/vim-tmux-navigator
-- Moving out of a zoomed nvim pane keeps the tmux window zoomed
vim.g.tmux_navigator_preserve_zoom = 1

vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr>')
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr>')
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<cr>')
