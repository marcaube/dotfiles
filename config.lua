-- General
-- ---------------------------------------------------------------------------
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "iceberg"

vim.opt.colorcolumn = "80,120,160"  -- rulers at 120 and 160 chars
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


-- Colemak remaps (you'll probably want to remove those if you're on QWERTY)
-- ---------------------------------------------------------------------------

-- Cursor movement (mnei instead of hjkl)
lvim.keys.normal_mode["m"] = "h"
lvim.keys.normal_mode["n"] = "j"
lvim.keys.normal_mode["e"] = "k"
lvim.keys.normal_mode["i"] = "l"

lvim.keys.visual_mode["m"] = "h"
lvim.keys.visual_mode["n"] = "j"
-- lvim.keys.visual_mode["N"] = "J" -- TODO: does not work...
lvim.keys.visual_mode["e"] = "k"
-- lvim.keys.visual_mode["E"] = "K" -- TODO: does not work...
lvim.keys.visual_mode["i"] = "l"

-- Faster Up/Down navigation
lvim.keys.normal_mode["N"] = "5j"
lvim.keys.normal_mode["E"] = "5k"

-- Faster word movement
lvim.keys.normal_mode["W"] = "5w"
lvim.keys.normal_mode["B"] = "5b"

-- Goto start/end of line faster than with 0 and $
lvim.keys.normal_mode["M"] = "^"
lvim.keys.normal_mode["I"] = "$"

-- Insert key
lvim.keys.normal_mode["k"] = "i"
lvim.lsp.buffer_mappings.normal_mode["K"] = "<Nop>"  -- Unmap the K key used by lsp (https://github.com/LunarVim/LunarVim/pull/1687)
lvim.keys.normal_mode["K"] = "I"

-- Remap J to "end of word", has a nice symetry with B
lvim.keys.normal_mode["j"] = "e"
lvim.keys.normal_mode["J"] = "5e"

-- Move selected line / block of text in visual mode
lvim.keys.visual_block_mode["N"] = ":move '>+1<CR>gv-gv"
lvim.keys.visual_block_mode["E"] = ":move '<-2<CR>gv-gv"

-- ---------------------------------------------------------------------------



-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa!<CR>", "Quit all" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>:Telescope find_files hidden=true<cr>", "Find file" }

-- Quickly toggle between files with leader-leader
lvim.builtin.which_key.mappings["<leader>"] = { "<C-^>", "Previous Buffer" }

lvim.builtin.which_key.mappings["t"] = {
    name = "+Custom Leader Keys",
    f = { "<cmd>:TestFile<cr>", "Test file"},
    n = { "<cmd>:TestNearest<cr>", "Test nearest"},
    l = { "<cmd>:TestLast<cr>", "Test last"},
    s = { "<cmd>:TestSuite<cr>", "Test suite"},
    v = { "<cmd>:TestVisit<cr>", "Visit last test file"},
}


-- Additional Plugins
-- ---------------------------------------------------------------------------
lvim.plugins = {
    {"arcticicestudio/nord-vim"},
    {"cocopon/iceberg.vim"},
    {"vim-test/vim-test"},
    {"tpope/vim-surround"},
    {"tpope/vim-repeat"},
    {"christoomey/vim-tmux-navigator"},
}


-- MISC (telescope, treesitter, LSP, linters, etc)
-- ---------------------------------------------------------------------------

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-n>"] = actions.move_selection_next,
    ["<C-e>"] = actions.move_selection_previous,
  },
  -- for normal mode
  n = {
    ["<C-n>"] = actions.move_selection_next,
    ["<C-e>"] = actions.move_selection_previous,
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
