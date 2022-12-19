-- This shouldn't be needed, but my tmux navigator keybindings must be conflicting...
-- TODO: find and fix the issue instead of the patch
lvim.keys.normal_mode["<C-h>"] = ":TmuxNavigateLeft<cr>"
lvim.keys.normal_mode["<C-l>"] = ":TmuxNavigateRight<cr>"


-- Additional Leader bindings for WhichKey
-- ---------------------------------------------------------------------------
lvim.builtin.which_key.mappings["Q"] = { "<cmd>qa!<CR>", "Quit all" }


-- Additional Plugins
-- ---------------------------------------------------------------------------
lvim.plugins = {
    -- Plugins
    { "christoomey/vim-tmux-navigator" },

    -- Supercharge visual selection mode (https://vimtricks.com/p/vimtrick-region-expanding/)
    { "terryma/vim-expand-region" },
    { "jeetsukumaran/vim-pythonsense" },
}


-- Expand region
-- ---------------------------------------------------------------------------
vim.g['expand_region_text_objects_python'] = {
    ['i"'] = 1, -- inside double-quotes
    ['i\''] = 1, -- inside quotes
    ['i]'] = 1, -- inside square brackets
    ['ib'] = 1, -- inside parens
    ['iB'] = 1, -- inside curly-braces
    ['if'] = 1, -- inside function
    ['af'] = 1, -- around function
    ['ic'] = 1, -- inside class
    ['ac'] = 1, -- around class
}

-- lvim.keys.visual_mode["v"] = "<Plug>(expand_region_expand)"
-- lvim.keys.visual_mode["<C-v>"] = "<Plug>(expand_region_shrink)"


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
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false


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

