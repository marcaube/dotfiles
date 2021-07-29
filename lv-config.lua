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
O.default_options.colorcolumn = "120"
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


-- Javascript
-- ---------------------------------------------------------------------------
O.lang.tsserver.linter = nil


-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
O.user_which_key = {
  Q = { ":qa!<cr>", "Quit all" },
  t = {
    name = "+Custom Leader Keys",
    t = { "<cmd>:split term://zsh<cr>:startinsert<cr>", "Open a terminal" },  -- Open terminal in insert mode
    f = { "<cmd>:TestFile<cr>", "Test file"},
    n = { "<cmd>:TestNearest<cr>", "Test nearest"},
    l = { "<cmd>:TestLast<cr>", "Test last"},
    s = { "<cmd>:TestSuite<cr>", "Test suite"},
    v = { "<cmd>:TestVisit<cr>", "Visit last test file"},
 },
}

-- Terminal (TODO: do the same in Lua)
vim.cmd("tnoremap <Esc> <C-\\><C-n>")  -- Let ESC go back to normal mode in the terminal
vim.cmd("au BufEnter * if &buftype == 'terminal' | :resize 15 | endif") -- resize to 15 rows

-- TODO: add a keymap to show a function definition

