-- General
-- ---------------------------------------------------------------------------

O.format_on_save = true
O.completion.autocomplete = true
O.colorscheme = "nord"
O.auto_close_tree = 0
O.default_options.wrap = true
O.default_options.timeoutlen = 100
O.leader_key = " "

-- Editor Preferences
O.default_options.hlsearch = true
O.default_options.colorcolumn = "120,160"
O.default_options.showmode = true
O.default_options.relativenumber = true
O.default_options.spelllang = ""
O.default_options.incsearch = true
O.default_options.foldlevel = 2
O.default_options.foldmethod = "syntax"
O.default_options.foldlevelstart = 99

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
O.plugin.dashboard.active = true
O.plugin.dashboard.custom_section.f = {
  description = { "📖 Vim Journal        " },
  command = ":e ~/vim-journal.md",
} 
O.plugin.floatterm.active = true
O.plugin.zen.active = true
O.plugin.zen.window.height = 0.90

O.plugin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "maintained"
O.treesitter.ignore_install = { "haskell" }
O.treesitter.highlight.enabled = true


-- Additionnal Plugins
-- ---------------------------------------------------------------------------
O.user_plugins = {
  {"arcticicestudio/nord-vim"},
  {"joshdick/onedark.vim"},
  {"whatyouhide/vim-gotham"},
  {"tomasr/molokai"},
  {"vim-test/vim-test"}, 
  {"tpope/vim-surround"},
  {"tpope/vim-repeat"},
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
}


-- Python
-- ---------------------------------------------------------------------------
require'lspconfig'.pyright.setup{}
O.lang.python.linter = 'flake8'
O.lang.python.isort = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.analysis.use_library_code_types = true
-- to change default formatter from yapf to black
-- O.lang.python.formatter.exe = "black"
-- O.lang.python.formatter.args = {"-"}
local dap_install = require "dap-install"
dap_install.config("python_dbg", {})


-- Javascript
-- ---------------------------------------------------------------------------
O.lang.tsserver.linter = nil


-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
O.user_which_key = {
  [" "] = { "<C-^>", "Previous buffer"},
  Q = { ":qa!<cr>", "Quit all" },
  t = {
    name = "+Custom Leader Keys",
    t = { "<CMD>lua require('FTerm').toggle()<CR>", "Open a terminal" },  -- Open terminal in insert mode
    f = { "<cmd>:TestFile<cr>", "Test file"},
    n = { "<cmd>:TestNearest<cr>", "Test nearest"},
    l = { "<cmd>:TestLast<cr>", "Test last"},
    s = { "<cmd>:TestSuite<cr>", "Test suite"},
    v = { "<cmd>:TestVisit<cr>", "Visit last test file"},
 },
 ["f"] = { "<cmd>:Telescope find_files hidden=true<cr>", "Find file" },
}

-- Add undo breakpoints after certain characters
vim.cmd("inoremap , ,<c-g>u")
vim.cmd("inoremap . .<c-g>u")
vim.cmd("inoremap ! !<c-g>u")
vim.cmd("inoremap ? ?<c-g>u")


