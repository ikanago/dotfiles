#!/bin/sh
set -eu

# Claude Code hook handler
# Reads JSON from stdin and updates tmux user option with status emoji

_update_tmux_window_status() {
    emoji="$1"
    pane_id="$TMUX_PANE"

    [ -z "$pane_id" ] && return

    window_id=$(tmux display-message -p -t "$pane_id" '#I' 2> /dev/null) || return
    tmux set-option -w -t "$window_id" @claude_status "$emoji" 2> /dev/null
}

_notify() {
    notification_sound_path="/System/Library/Sounds/Purr.aiff"
    [ -e $notification_sound_path ] && afplay $notification_sound_path
}

input=$(cat)

hook_event=$(echo "$input" | jq -r '.hook_event_name // empty')

case "$hook_event" in
    Notification)
        notification_type=$(echo "$input" | jq -r '.notification_type // empty')
        if [ "$notification_type" = "permission_prompt" ]; then
            _update_tmux_window_status "🔴"
            _notify
        fi
        ;;
    PostToolUse | UserPromptSubmit)
        _update_tmux_window_status "🟡"
        ;;
    Stop)
        _update_tmux_window_status "🟢"
        _notify
        ;;
    SessionEnd)
        _update_tmux_window_status ""
        ;;
esac
