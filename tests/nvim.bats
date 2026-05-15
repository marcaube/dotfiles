#!/usr/bin/env bats

@test "nvim lua modules all exist" {
  [ -f "$HOME/.config/nvim/lua/keymaps.lua" ]
  [ -f "$HOME/.config/nvim/lua/options.lua" ]
  [ -f "$HOME/.config/nvim/lua/plugins.lua" ]
  [ -f "$HOME/.config/nvim/lua/lsp.lua" ]
}

@test "nvim starts without lua errors" {
  nvim --headless -c "lua print('ok')" -c "qa!" 2>/tmp/nvim_lua_test
  run grep -i "error" /tmp/nvim_lua_test
  [ "$status" -ne 0 ]
}
