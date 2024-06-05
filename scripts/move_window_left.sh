#!/bin/dash
curWindowId="$(yabai -m query --windows --window | jq -re ".id")"

is_float=$(yabai -m query --windows --window $curWindowId | jq '."is-floating"')

_move_left_window() {
  return $(yabai -m window --swap west || yabai -m window --display west)
}

_move_left_float_display() {
  return $(yabai -m window --grid 1:2:0:0:1:1)
}

! $is_float && _move_left_window
$is_float && _move_left_float_display


$(yabai -m window --focus "$curWindowId")
