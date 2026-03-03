#!/bin/bash

# Path to the audio file
AUDIO_FILE="/Users/kaulmesanyam/workspace/faahh/fahhhhh.mp3"

# For ZSH
if [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        echo "zsh: command not found: $1" >&2
        if [ -f "$AUDIO_FILE" ]; then
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
        if [ -f "$AUDIO_FILE" ]; then
            afplay "$AUDIO_FILE" &
        fi
        return 127
    }
fi
