-- https://github.com/folke/which-key.nvim
vim.opt.timeoutlen = 250

local wk = require('which-key')

-- Top level Items
wk.add({
  { "<leader>h", "<cmd>nohlsearch<cr>", desc = "No Highlight" },
  { "<leader>w", "<cmd>w!<cr>", desc = "Save" },
  { "<leader>x", "<cmd>bd<cr>", desc = "Close buffer" },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
  { "<leader>Q", "<cmd>qa!<cr>", desc = "Quit All" },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open File Explorer" },
  { "<leader>/", "gcc", desc = "Comment toggle current line" },
  { "<leader>r", "<cmd>source ~/.config/nvim/init.lua<cr>", desc = "Reload config" },
})

-- Keybinding categories
wk.add({
  -- Git Commands
  -- Branch ops, commit graph, staging, and diffs go through lazygit (<leader>gg).
  -- These bindings cover cursor/buffer-scoped ops lazygit can't reach as fast.
  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
  { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
  { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "File history" },

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
  { "<leader>d", group = "Debug" },
  { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Condition: ')) end, desc = "Conditional Breakpoint" },
  { "<leader>dl", "<cmd>Telescope dap list_breakpoints<cr>", desc = "List Breakpoints" },
  { "<leader>db", function() require("dap").step_back() end, desc = "Step Back" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
  { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
  { "<leader>dg", function() require("dap").session() end, desc = "Get Session" },
  { "<leader>df", function() require("dap").focus_frame() end, desc = "Focus execution point" },
  { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
  { "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },
  { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
  { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },
  { "<leader>ds", function() require("dap").continue() end, desc = "Start" },
  { "<leader>dR", function() require("dap").run_last() end, desc = "Rerun Last" },
  { "<leader>dq", function() require("dap").close() end, desc = "Quit" },
  { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI" },
  { "<leader>dT", function() require("dap-python").test_method() end, desc = "Debug Test Method" },
  { "<leader>dK", function() require("dap-python").test_class() end, desc = "Debug Test Class" },

  -- LSP
  { "<leader>l", group = "LSP" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
  { "<leader>ld", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end, desc = "Buffer Diagnostics" },
  { "<leader>lw", function() require("telescope.builtin").diagnostics() end, desc = "Workspace Diagnostics" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason Info" },
  { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
  { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
  { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  { "<leader>le", function() require("telescope.builtin").quickfix() end, desc = "Telescope Quickfix" },

  -- Refactoring
  { "<leader>R", group = "Refactor" },
  { "<leader>Re", function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function", mode = "v" },
  { "<leader>Rf", function() require('refactoring').refactor('Extract Function To File') end, desc = "Extract To File", mode = "v" },
  { "<leader>Rv", function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable", mode = "v" },
  { "<leader>Ri", function() require('refactoring').refactor('Inline Variable') end, desc = "Inline Variable" },
  { "<leader>Rb", function() require('refactoring').refactor('Extract Block') end, desc = "Extract Block" },
  { "<leader>Rr", function() require('refactoring').select_refactor() end, desc = "Select Refactor", mode = { "n", "v" } },
  { "<leader>Ra", function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end, desc = "Swap parameter with next" },
  { "<leader>RA", function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end, desc = "Swap parameter with previous" },

  -- Package Management
  { "<leader>p", group = "Lazy.nvim" },
  { "<leader>pc", "<cmd>Lazy check<cr>", desc = "Check for updates and show the log" },
  { "<leader>pC", "<cmd>Lazy clean<cr>", desc = "Clean plugins that are no longer needed" },
  { "<leader>ph", "<cmd>Lazy health<cr>", desc = "Health Check" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install missing plugins" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync (Run install, clean and update)" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },

  -- UI Toggles
  { "<leader>u", group = "UI Toggle" },
  { "<leader>ub", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Live blame" },
  { "<leader>uc", function()
    if vim.wo.colorcolumn == "" then
      vim.wo.colorcolumn = "80,120,160"
    else
      vim.wo.colorcolumn = ""
    end
  end, desc = "Color columns" },
  { "<leader>uf", function()
    local show = not vim.wo.number
    vim.wo.number = show
    vim.wo.relativenumber = show
    vim.wo.signcolumn = show and "yes" or "no"
    vim.cmd(show and "IBLEnable" or "IBLDisable")
  end, desc = "Focus mode (hide UI chrome)" },
  { "<leader>uk", "<cmd>CloakToggle<cr>", desc = "Cloak (.env masking)" },
  { "<leader>ul", "<cmd>set relativenumber!<cr>", desc = "Relative line numbers" },
  { "<leader>us", "<cmd>set spell!<cr>", desc = "Spell" },
  { "<leader>uw", "<cmd>set wrap!<cr>", desc = "Wrap" },
  { "<leader>uz", "<cmd>set foldcolumn=0<cr>", desc = "Fold column" },
})
