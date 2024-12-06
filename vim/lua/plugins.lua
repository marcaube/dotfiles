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
    -- TODO: confirm configs
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {},
    },

    -- Git related plugins
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "lewis6991/gitsigns.nvim" },

    -- Color Schemes
    { 
      -- https://github.com/catppuccin/nvim
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      init = function()
	vim.cmd.colorscheme "catppuccin-mocha"
	vim.o.termguicolors = true
      end,
    },

    -- UI enhancements
    { "nvim-lualine/lualine.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },
    { "numToStr/Comment.nvim" },
    { "tpope/vim-sleuth" },

    -- Navigation
    { "nvim-tree/nvim-tree.lua" },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { "ggandor/leap.nvim" },
    { "christoomey/vim-tmux-navigator" },
    {
      "ThePrimeagen/harpoon",
      dependencies = { "nvim-lua/plenary.nvim" },
    },


    -- Keybindings
    { "folke/which-key.nvim" },

    -- Text manipulation
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "windwp/nvim-autopairs" },

    -- Testing
    { "vim-test/vim-test" },

    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "mfussenegger/nvim-dap-python" },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },

    -- Copilot
    { "github/copilot.vim" },

    -- Fuzzy Finder
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable("make") == 1,
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin-mocha" } },

  -- automatically check for plugin updates
  checker = { enabled = true },
})
