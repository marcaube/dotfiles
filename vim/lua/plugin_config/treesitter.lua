-- [[ Configure Treesitter (main branch — Nvim 0.12+) ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter').install({ 'lua', 'python', 'rust', 'typescript' })

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft
    if pcall(vim.treesitter.start, args.buf, lang) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

local function sel(obj)
  return function() select.select_textobject(obj, 'textobjects') end
end

vim.keymap.set({ 'x', 'o' }, 'aa', sel('@parameter.outer'))
vim.keymap.set({ 'x', 'o' }, 'ia', sel('@parameter.inner'))
vim.keymap.set({ 'x', 'o' }, 'af', sel('@function.outer'))
vim.keymap.set({ 'x', 'o' }, 'if', sel('@function.inner'))
vim.keymap.set({ 'x', 'o' }, 'ac', sel('@class.outer'))
vim.keymap.set({ 'x', 'o' }, 'ic', sel('@class.inner'))

vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

