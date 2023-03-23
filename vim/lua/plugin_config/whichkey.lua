-- https://github.com/folke/which-key.nvim
vim.opt.timeoutlen = 250

require('which-key').setup {
  ignore_missing = true,
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 10, -- spacing between columns
    align = 'center', -- align columns left, center or right
  },
}

local wk = require('which-key')

-- Top level Items
wk.register({
  ['<leader>h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
  ['<leader>w'] = { '<cmd>w!<cr>', 'Save' },
  ['<leader>c'] = { '<cmd>bd<CR>', 'Close buffer' },
  ['<leader>q'] = { '<cmd>q<cr>', 'Quit' },
  ['<leader>Q'] = { '<cmd>qa!<cr>', 'Quit All' },
  ['<leader>e'] = { '<cmd>NvimTreeToggle<cr>', 'Open File Explorer' },
  ['<leader>/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment toggle current line' },
  ['<leader>r'] = { '<cmd>source  ~/.config/nvim/init.lua<cr>', 'Reload config'},
})

-- Categories
wk.register({
  ["<leader>"] = {

    -- Git
    g = {
      name = "Git",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      L = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Live Blame toggle" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
      },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
      S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage buffer" },
    },

    -- Search and Navigation
    s = {
      name = "Search",
      b = { "<cmd>Telescope buffers<cr>", "Open buffers" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      F = { "<cmd>:Telescope find_files hidden=true no_ignore=true<cr>", "Find all File" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Grep Text" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      p = {
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
      w = { "<cmd>Telescope grep_string<cr>", "Search current Word" },
      ["/"] = {
        function()
          local builtin = require('telescope.builtin')
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        "[/] Fuzzily search in current buffer"
      },
    },

    n = {
      name = "Harpoon",
      h = { function () require("harpoon.ui").toggle_quick_menu() end, "Toggle Harpoon quick menu"},
      m = { function () require("harpoon.mark").add_file() end, "Add mark"},

      -- Move to files 1 to 4 using neio
      n = { function () require("harpoon.ui").nav_file(1) end, "Goto mark 1"},
      e = { function () require("harpoon.ui").nav_file(2) end, "Goto mark 2"},
      i = { function () require("harpoon.ui").nav_file(3) end, "Goto mark 3"},
      o = { function () require("harpoon.ui").nav_file(4) end, "Goto mark 4"},
    },

    -- Testing
    -- https://github.com/vim-test/vim-test
    t = {
      name = "Test",
      f = { "<cmd>:TestFile<cr>", "Test File" },
      n = { "<cmd>:TestNearest<cr>", "Test Nearest" },
      l = { "<cmd>:TestLast<cr>", "Test Last" },
      s = { "<cmd>:TestSuite<cr>", "Test Suite"},
      v = { "<cmd>:TestVisit<cr>", "Visit last test file"},
    },

    -- Debugging
    d = {
      name = "Debug",
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    },

    -- LSP
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      -- f = { require("lvim.lsp.utils").format, "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      j = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
      },
      k = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
      },
      l = { vim.lsp.codelens.run, "CodeLens Action" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      r = { vim.lsp.buf.rename, "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },

    -- Package Management
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
  }
})
