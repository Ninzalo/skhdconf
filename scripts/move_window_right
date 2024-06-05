#!/bin/dash
curWindowId="$(yabai -m query --windows --window | jq -re ".id")"

is_float=$(yabai -m query --windows --window $curWindowId | jq '."is-floating"')
displays_amount=$(yabai -m query --displays | jq length)
display_index=$(yabai -m query --displays --display | jq '."index"')
display_start_pos=$(yabai -m query --displays --display | jq '."frame".x')
display_end_pos=$(yabai -m query --displays --display | jq '."frame".w')
display_middle_pos=$(echo "scale=4; $(yabai -m query --displays --display | jq '."frame".w / 2') - 10.0000" | bc -l)

x_left_pos=$(yabai -m query --windows --window $curWindowId | jq '."frame".x')
x_left_pos_rel_display=$(echo "scale=4; $x_left_pos - $display_start_pos" | bc -l)
x_right_pos_rel_display=$(yabai -m query --windows --window $curWindowId | jq '."frame".w')

echo $x_left_pos
echo $x_left_pos_rel_display
echo $x_right_pos_rel_display
echo $display_end_pos
echo $display_middle_pos

_move_right_window() {
  return $(yabai -m window --swap east || yabai -m window --display east)
}

_move_right_float_display() {
  return $(yabai -m window --grid 1:2:1:0:1:1)
}

! $is_float && _move_right_window

$is_float && _move_right_float_display


$(yabai -m window --focus "$curWindowId")
