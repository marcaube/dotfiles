-- https://github.com/folke/which-key.nvim
vim.opt.timeoutlen = 250

local wk = require('which-key')

-- Top level Items
wk.add({
  { "<leader>h", "<cmd>nohlsearch<cr>", desc = "No Highlight" },
  { "<leader>w", "<cmd>w!<cr>", desc = "Save" },
  { "<leader>c", "<cmd>bd<cr>", desc = "Close buffer" },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
  { "<leader>Q", "<cmd>qa!<cr>", desc = "Quit All" },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open File Explorer" },
  { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment toggle current line" },
  { "<leader>r", "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Reload config" },
})

-- Keybinding categories
wk.add({
  -- Git Commands
  { "<leader>g", group = "Git" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
  { "<leader>gL", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Live Blame toggle" },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
  { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout commit (buffer)" },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
  { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
  { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },

  -- Search and Navigation
  { "<leader>s", group = "Search" },
  { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
  { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>sF", "<cmd>:Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find all File" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
  { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Find highlight groups" },
  { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
  { "<leader>sQ", "<cmd>Telescope quickfixhistory<cr>", desc = "Quickfix history" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "Grep Text" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  {
    "<leader>sp",
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    desc = "Colorscheme with Preview",
  },
  { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search current Word" },
  {
    "<leader>s/",
    function()
      local builtin = require('telescope.builtin')
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 15,
        previewer = false,
      })
    end,
    desc = "[/] Fuzzily search in current buffer",
  },

  -- Harpoon
  { "<leader>n", group = "Harpoon" },
  { "<leader>nh", function () require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon quick menu" },
  { "<leader>nm", function () require("harpoon.mark").add_file() end, desc = "Add mark" },
  -- Move to files 1 to 4 using neio
  { "<leader>nn", function () require("harpoon.ui").nav_file(1) end, desc = "Goto mark 1" },
  { "<leader>ne", function () require("harpoon.ui").nav_file(2) end, desc = "Goto mark 2" },
  { "<leader>ni", function () require("harpoon.ui").nav_file(3) end, desc = "Goto mark 3" },
  { "<leader>no", function () require("harpoon.ui").nav_file(4) end, desc = "Goto mark 4" },

  -- Testing
  -- https://github.com/vim-test/vim-test
  { "<leader>t", group = "Testing" },
  { "<leader>tf", "<cmd>:TestFile<cr>", desc = "Test File" },
  { "<leader>tn", "<cmd>:TestNearest<cr>", desc = "Test Nearest" },
  { "<leader>tl", "<cmd>:TestLast<cr>", desc = "Test Last" },
  { "<leader>ts", "<cmd>:TestSuite<cr>", desc = "Test Suite" },
  { "<leader>tv", "<cmd>:TestVisit<cr>", desc = "Visit last test file" },

  -- Debugging (dap)
  -- TODO: https://github.com/marcaube/dotfiles/blob/master/vim/lua/plugin_config/whichkey.lua#L118-L134

  -- LSP
  -- TODO: https://github.com/marcaube/dotfiles/blob/master/vim/lua/plugin_config/whichkey.lua#L137-L162
  { "<leader>l", group = "LSP" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

  -- Package Management
  { "<leader>p", group = "Lazy.nvim" },
  { "<leader>pc", "<cmd>Lazy check<cr>", desc = "Check for updates and show the log" },
  { "<leader>pC", "<cmd>Lazy clean<cr>", desc = "Clean plugins that are no longer needed" },
  { "<leader>ph", "<cmd>Lazy health<cr>", desc = "Health Check" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install missing plugins" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync (Run install, clean and update)" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },
})
