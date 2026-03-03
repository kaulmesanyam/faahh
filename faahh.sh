#!/bin/bash

# Path to the audio file
AUDIO_FILE="/Users/kaulmesanyam/workspace/faahh/fahhhhh.mp3"

# Flag to control if faahh is enabled (1 = enabled, 0 = disabled)
export FAAHH_ENABLED=1

# Function to toggle faahh
faahh() {
    if [ "$1" = "--start" ]; then
        export FAAHH_ENABLED=1
        echo "Faahh is now ENABLED."
    elif [ "$1" = "--stop" ]; then
        export FAAHH_ENABLED=0
        echo "Faahh is now DISABLED."
    else
        echo "Usage: faahh [--start | --stop]"
        echo "  --start   Enable playing audio on command not found"
        echo "  --stop    Disable playing audio on command not found"
    fi
}

# For ZSH
if [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        echo "zsh: command not found: $1" >&2
        if [ "$FAAHH_ENABLED" -eq 1 ] && [ -f "$AUDIO_FILE" ]; then
            # afplay is the built-in audio player on macOS
            afplay "$AUDIO_FILE" &
        fi
        return 127
    }
fi

# For BASH
if [ -n "$BASH_VERSION" ]; then
    command_not_found_handle() {
        echo "bash: $1: command not found" >&2
        if [ "$FAAHH_ENABLED" -eq 1 ] && [ -f "$AUDIO_FILE" ]; then
            afplay "$AUDIO_FILE" &
        fi
        return 127
    }
fi
