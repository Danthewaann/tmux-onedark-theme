#!/bin/bash
onedark_black="#1a1d21"
onedark_black2="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_purple="#c678dd"
onedark_green="#8ebd6b"
onedark_visual_grey="#323641"
onedark_comment_grey="#5c6370"
onedark_search="#464d5e"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "200"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-style" "fg=$onedark_white,bg=$onedark_black"

set "message-command-style" "fg=$onedark_white,bg=$onedark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-style" "fg=$onedark_black,bg=$onedark_black"
setw "window-status-attr" "none"

setw "window-status-activity-style" "fg=$onedark_black,bg=$onedark_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$onedark_white"
set "window-active-style" "fg=$onedark_white"

set "pane-border-status" "top"
set "pane-border-format" ""
set "pane-border-style" "fg=$onedark_visual_grey,bg=$onedark_black"
set "pane-active-border-style" "fg=$onedark_visual_grey,bg=$onedark_black"

set "mode-style" "fg=$onedark_white,bg=$onedark_visual_grey"
set "copy-mode-current-match-style" "bg=$onedark_search"
set "copy-mode-match-style" "bg=$onedark_search"

set "display-panes-active-colour" "$onedark_yellow"
set "display-panes-colour" "$onedark_blue"

set "status-style" "fg=$onedark_white,bg=$onedark_black"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_green"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_green"
set "@prefix_highlight_output_prefix" " / "

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y ")

set "status-right" " ${date_format}${status_widgets}| ${time_format} "
set "status-left" "#[fg=$onedark_black,bg=$onedark_green,bold] #S #{prefix_highlight}#[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"

if [[ $SHOW_DIRECTORY_NAME -eq 1 ]]; then
    set "window-status-format" "#[fg=$onedark_white,bg=$onedark_black] #I:#(tmux-rename-window #{pane_current_path} #S)#W "
    set "window-status-current-format" "#[fg=$onedark_green,bg=$onedark_black,nobold]#[fg=$onedark_black,bg=$onedark_green,bold] #I:#(tmux-rename-window #{pane_current_path})#W #[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"
else
    set "window-status-format" "#[fg=$onedark_white,bg=$onedark_black] #I:#W "
    set "window-status-current-format" "#[fg=$onedark_green,bg=$onedark_black,nobold]#[fg=$onedark_black,bg=$onedark_green,bold] #I:#W #[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"
fi
