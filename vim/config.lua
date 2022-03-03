-- General
-- ---------------------------------------------------------------------------
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "iceberg"

vim.opt.colorcolumn = "80,120,160"  -- rulers at 80, 120 and 160 chars
vim.opt.showmode = true             -- show the current editor mode in the statusline
vim.opt.relativenumber = true       -- makes jumping around a lot easier
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


-- Key mappings
-- ---------------------------------------------------------------------------
lvim.leader = "space"
lvim.keys.normal_mode[";"] = ":"

-- Save file using C-s
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Select All using C-a
lvim.keys.normal_mode["<C-a>"] = "ggVG"

-- Use tab to navigate to matching parens and brackets
lvim.keys.normal_mode["<tab>"] = "%"
lvim.keys.visual_mode["<tab>"] = "%"

-- Add undo breakpoints after certain characters
vim.cmd("inoremap , ,<c-g>u")
vim.cmd("inoremap . .<c-g>u")
vim.cmd("inoremap ! !<c-g>u")
vim.cmd("inoremap ? ?<c-g>u")

-- Make Y copy till the end of the line
lvim.keys.normal_mode["Y"] = "y$"

-- Quick indentation
lvim.keys.normal_mode[">"] = ">>"
lvim.keys.normal_mode["<"] = "<<"

-- This shouldn't be needed, but my tmux navigator keybindings must be conflicting...
-- TODO: find and fix the issue instead of the patch
lvim.keys.normal_mode["<C-h>"] = ":TmuxNavigateLeft<cr>"
lvim.keys.normal_mode["<C-l>"] = ":TmuxNavigateRight<cr>"


-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa!<CR>", "Quit all" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>:Telescope find_files hidden=true<cr>", "Find file" }

-- Quickly toggle between files with leader-leader
lvim.builtin.which_key.mappings["<leader>"] = { "<C-^>", "Previous Buffer" }

-- Shortcuts for tests
lvim.builtin.which_key.mappings["t"] = {
    name = "+Custom Leader Keys",
    f = { "<cmd>:TestFile<cr>", "Test file"},
    n = { "<cmd>:TestNearest<cr>", "Test nearest"},
    l = { "<cmd>:TestLast<cr>", "Test last"},
    s = { "<cmd>:TestSuite<cr>", "Test suite"},
    v = { "<cmd>:TestVisit<cr>", "Visit last test file"},
}

-- Zen Mode 🧘
lvim.builtin.which_key.mappings["Z"] = { "<cmd>:ZenMode<cr>", "Zen Mode" }


-- Additional Plugins
-- ---------------------------------------------------------------------------
lvim.plugins = {
    {"arcticicestudio/nord-vim"},
    {"cocopon/iceberg.vim"},
    {"vim-test/vim-test"},
    {"tpope/vim-surround"},
    {"tpope/vim-repeat"},
    {"christoomey/vim-tmux-navigator"},
    {"folke/zen-mode.nvim"},
}


-- Dashboard
-- ---------------------------------------------------------------------------
lvim.builtin.dashboard.custom_header = {
    '',
    '',
    '',
    '',
    '',
    '',
    '███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    '████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    '██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    '██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    '██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    '╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}
lvim.builtin.dashboard.disable_at_vim_enter = 1

-- https://www.lunarvim.org/configuration/06-statusline.html#style
lvim.builtin.lualine.style = "default"

-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
lvim.builtin.lualine.options.theme = "iceberg"


-- MISC (telescope, treesitter, LSP, linters, etc)
-- ---------------------------------------------------------------------------

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
