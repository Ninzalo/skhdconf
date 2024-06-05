#!/bin/sh

curWindowId="$(yabai -m query --windows --window | jq -re ".id")"
is_float=$(yabai -m query --windows --window $curWindowId | jq '."is-floating"')

x_pos=$(yabai -m query --windows --window $curWindowId | jq '.frame.x')
display_index=$(yabai -m query --displays --display | jq '."index"')

display_start_pos=$(yabai -m query --displays --display | jq '."frame".x')
display_width=$(yabai -m query --displays --display | jq '."frame".w')
full_hd_ratio=$(echo "scale=4; $display_width / 1920.0000" | bc -l)
xpt=$(echo "scale=4; ($x_pos - $display_start_pos) / $full_hd_ratio" | bc -l)

_max() {
    yabai -m window $curWindowId --grid 1:1:1:1:1:1
}

_big() {
    yabai -m window $curWindowId --grid 16:32:4:2:24:12
}

_medium() {
    yabai -m window $curWindowId --grid 16:32:6:2:20:12
}

_small() {
    yabai -m window $curWindowId --grid 16:32:8:3:16:10
}

_toggle_float() {
  return $(yabai -m window $curWindowId --toggle zoom-fullscreen --toggle float)
}

! $is_float && [[ $xpt < 1 ]] && _toggle_float && _small && return

$is_float && [[ $xpt > 481 ]] && _small
$is_float && [[ $xpt < 481 && $xpt > 361 ]] && _medium
$is_float && [[ $xpt < 361 && $xpt > 241 ]] && _big
$is_float && [[ $xpt < 241 && $xpt > 1 ]] && _max
$is_float && [[ $xpt < 1 ]] && _toggle_float
