#!/usr/bin/env bash

idx=$(niri msg -j workspaces | jq -r ".[] | select(.is_focused == true) | .idx")

niri msg action move-workspace-to-index 4
niri msg action focus-workspace " " 
niri msg action move-workspace-to-index $idx
niri msg action unset-workspace-name
niri msg action focus-workspace 4 && niri msg action set-workspace-name " "
