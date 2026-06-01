-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- LSP Configuration & Plugins
    {
      -- https://github.com/neovim/nvim-lspconfig
      "neovim/nvim-lspconfig",
      dependencies = {
	-- Automatically install LSPs to stdpath for neovim
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Useful status updates for LSP
	"j-hui/fidget.nvim",
      },
    },

    -- Autocompletion
    {
      -- https://github.com/hrsh7th/nvim-cmp
      "hrsh7th/nvim-cmp",
      dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
      },
    },

    -- VSCode snippets
    { "rafamadriz/friendly-snippets" },

    -- Highlight, edit, and navigate code
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      },
    },

    -- Sticky context header showing the enclosing scope (function/class/etc.)
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPost",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function() require('plugin_config.treesitter-context') end,
    },

    -- Git related plugins
    {
      "tpope/vim-fugitive",
      cmd = { "Git", "Gdiffsplit", "Gread", "GBrowse" },
    },
    { "tpope/vim-rhubarb" },
    {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      config = function() require('plugin_config.gitsigns') end,
    },

    -- Color Schemes
    {
      -- https://github.com/catppuccin/nvim
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
	vim.o.termguicolors = true
	vim.cmd.colorscheme "catppuccin-mocha"
      end,
    },

    -- UI enhancements
    { "nvim-lualine/lualine.nvim" },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPost",
      config = function() require('plugin_config.indent_blankline') end,
    },
    { "tpope/vim-sleuth" },

    -- Navigation
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function() require('plugin_config.nvim-tree') end,
    },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    {
      "folke/flash.nvim",
      keys = {
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
      opts = {},
    },
    {
      "christoomey/vim-tmux-navigator",
      event = "VeryLazy",
      config = function() require('plugin_config.tmux-navigator') end,
    },
    {
      "ThePrimeagen/harpoon",
      event = "VeryLazy",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Keybindings
    { "folke/which-key.nvim" },

    -- Text manipulation
    {
      "tpope/vim-surround",
      event = "BufReadPost",
    },
    {
      "tpope/vim-repeat",
      event = "BufReadPost",
    },
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function() require('plugin_config.autopairs') end,
    },

    -- Testing
    {
      "vim-test/vim-test",
      cmd = { "TestFile", "TestNearest", "TestLast", "TestSuite", "TestVisit" },
      config = function() require('plugin_config.testing') end,
    },

    -- Refactoring
    {
      'ThePrimeagen/refactoring.nvim',
      event = 'BufReadPre',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'lewis6991/async.nvim',
      },
      config = function()
        require('refactoring').setup()
      end,
    },

    -- Git UI
    {
      'kdheepak/lazygit.nvim',
      cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter' },
      dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- Debugging
    -- Run :MasonInstall codelldb js-debug-adapter to enable Rust and TypeScript debugging
    { "mfussenegger/nvim-dap" },
    { "mfussenegger/nvim-dap-python" },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },

    -- Mask .env values on screen (useful for screensharing)
    {
      "laytan/cloak.nvim",
      event = "BufReadPre",
      config = function()
        require('cloak').setup({
          enabled = true,
          cloak_character = '*',
          highlight_group = 'Comment',
          patterns = {
            { file_pattern = { '.env', '.env.*', '*.env' }, cloak_pattern = '=.+' },
          },
        })
      end,
    },

    -- Copilot
    {
      "github/copilot.vim",
      event = "InsertEnter",
    },

    -- Fuzzy Finder
    {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      branch = "master",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = vim.fn.executable("make") == 1,
        },
        "nvim-telescope/telescope-ui-select.nvim",
      },
      config = function() require('plugin_config.telescope') end,
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin-mocha" } },

  -- automatically check for plugin updates
  checker = { enabled = true, notify = false, frequency = 86400 },

  -- disable luarocks integration to avoid jsregexp build failures with LuaSnip
  rocks = { enabled = false },
})
