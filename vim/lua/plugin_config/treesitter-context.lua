-- [[ Configure nvim-treesitter-context ]]
-- Sticky header showing the code context (function, class, etc.) the cursor
-- is inside of. See `:help treesitter-context`.
require('treesitter-context').setup({
  enable = true,
  max_lines = 3,           -- cap the context window so it never grows too tall
  multiline_threshold = 1, -- collapse multiline context to a single line
  trim_scope = 'outer',    -- drop outer scopes first when over max_lines
  mode = 'cursor',         -- show the context for the cursor's scope
})

-- Jump up to the start of the surrounding context
vim.keymap.set('n', '[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true, desc = 'Jump to [c]ontext' })
