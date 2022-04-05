-- General
-- ---------------------------------------------------------------------------
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "nord"

vim.opt.colorcolumn = "80,120,160"  -- rulers at 80, 120 and 160 chars
vim.opt.showmode = true             -- show the current editor mode in the statusline
vim.opt.relativenumber = true       -- makes jumping around a lot easier
vim.opt.shiftwidth = 4              -- Size of an indent
vim.opt.tabstop = 4                 -- Number of spaces tabs count for
vim.opt.scrolloff = 10              -- Keep more context at edge of screen
vim.opt.tw = 120                    -- Set the default texwidth to 120 chars for automatic formatting


-- Key mappings
-- ---------------------------------------------------------------------------
lvim.leader = "space"
lvim.keys.normal_mode[";"] = ":"    -- One less key to go into command-mode

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

-- Make Y copy till the end of the line, to behave more like C and D
lvim.keys.normal_mode["Y"] = "y$"

-- Go to the first caracter on the line with 00, since ^ is hard to type on my kb
lvim.keys.normal_mode["00"] = "^"

lvim.keys.normal_mode["E"] = "$"
lvim.keys.normal_mode["B"] = "0"

-- Quick indentation
lvim.keys.normal_mode[">"] = ">>"
lvim.keys.normal_mode["<"] = "<<"

-- This shouldn't be needed, but my tmux navigator keybindings must be conflicting...
-- TODO: find and fix the issue instead of the patch
lvim.keys.normal_mode["<C-h>"] = ":TmuxNavigateLeft<cr>"
lvim.keys.normal_mode["<C-l>"] = ":TmuxNavigateRight<cr>"

-- Add a trailing-comma and come back
vim.cmd('nmap ,, mxA,<esc>`x')
vim.cmd('imap ,, <esc>mxA,<esc>`xa')

-- Add a trailing semi-colon and come back (Rust, PHP)
vim.cmd('nmap ;; mxA;<esc>`x')
vim.cmd('imap ; ;') -- There was a clash with an existing mapping
vim.cmd('imap ;; <esc>mxA;<esc>`xa')


-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa!<CR>", "Quit all" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>:Telescope find_files hidden=true no_ignore=true<cr>", "Find file" }

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
    -- Color schemes
    {"arcticicestudio/nord-vim"},
    {"cocopon/iceberg.vim"},
    {'michaeldyrynda/carbon'},

    -- Plugins
    {"vim-test/vim-test"},
    {"tpope/vim-surround"},
    {"tpope/vim-repeat"},
    {"christoomey/vim-tmux-navigator"},
    {"folke/zen-mode.nvim"},
}


-- Lualine
-- ---------------------------------------------------------------------------

-- https://www.lunarvim.org/configuration/06-statusline.html#style
lvim.builtin.lualine.style = "default"

-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
lvim.builtin.lualine.options.theme = "nord"


-- Vim-test
-- ---------------------------------------------------------------------------
vim.g['test#strategy'] = 'neovim' -- Pop a temporary split to run tests


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
