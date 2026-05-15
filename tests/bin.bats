#!/usr/bin/env bats

@test "all bin scripts have a valid shebang" {
  for script in "$DOTFILES/bin/"*; do
    run head -1 "$script"
    [[ "$output" =~ ^'#!' ]]
  done
}

@test "uuid produces a valid UUID" {
  run "$HOME/bin/uuid"
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]
}

@test "epoch converts a unix timestamp" {
  run env TZ=UTC "$HOME/bin/epoch" 1609459200
  [ "$status" -eq 0 ]
  [[ "$output" == *"ISO: 2021-01-01"* ]]
}

@test "epoch handles millisecond timestamps" {
  run env TZ=UTC "$HOME/bin/epoch" 1609459200000
  [ "$status" -eq 0 ]
  [[ "$output" == *"ISO: 2021-01-01"* ]]
}

@test "urlencode encodes spaces as %20" {
  run "$HOME/bin/urlencode" "hello world"
  [ "$status" -eq 0 ]
  [ "$output" = "hello%20world" ]
}
