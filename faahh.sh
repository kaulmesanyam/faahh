#!/bin/bash

# Determine the base directory of this script (works for both bash and zsh)
if [ -n "$BASH_SOURCE" ]; then
    # bash
    _FAAHH_BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
elif [ -n "$ZSH_VERSION" ]; then
    # zsh
    _FAAHH_BASE_DIR="$(cd "$(dirname "${(%):-%N}")" >/dev/null 2>&1 && pwd)"
else
    # fallback
    _FAAHH_BASE_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
fi

# Directory containing all Faahh audio files (relative to this script)
AUDIO_DIR="$_FAAHH_BASE_DIR/audio"

# Default audio file name (must exist in AUDIO_DIR)
DEFAULT_AUDIO_NAME="fahhhhh.mp3"

# Flag to control if faahh is enabled (1 = enabled, 0 = disabled)
export FAAHH_ENABLED=1

# If no custom audio has been chosen yet, default to the main sound
if [ -z "$FAAHH_AUDIO_FILE" ]; then
    export FAAHH_AUDIO_FILE="$AUDIO_DIR/$DEFAULT_AUDIO_NAME"
fi

# Helper to list available audio files (POSIX-compatible for both bash and zsh)
_faahh_list_audio() {
    if [ ! -d "$AUDIO_DIR" ]; then
        echo "Audio directory not found: $AUDIO_DIR"
        return 1
    fi

    found=0
    for f in "$AUDIO_DIR"/*.mp3; do
        # If the glob didn't match anything, skip the literal pattern
        if [ ! -e "$f" ]; then
            continue
        fi
        if [ "$found" -eq 0 ]; then
            echo "Available Faahh audio files:"
        fi
        found=1
        echo "  $(basename "$f")"
    done

    if [ "$found" -eq 0 ]; then
        echo "No .mp3 files found in $AUDIO_DIR"
        return 1
    fi
}

# Function to control Faahh behavior
faahh() {
    case "$1" in
        --start)
            export FAAHH_ENABLED=1
            echo "Faahh is now ENABLED."
            ;;
        --stop)
            export FAAHH_ENABLED=0
            echo "Faahh is now DISABLED."
            ;;
        --list)
            _faahh_list_audio
            ;;
        --*.mp3)
            # Usage: faahh --bkl.mp3
            local filename="${1#--}"
            local fullpath="$AUDIO_DIR/$filename"
            if [ -f "$fullpath" ]; then
                export FAAHH_AUDIO_FILE="$fullpath"
                echo "Faahh audio set to: $filename"
            else
                echo "Audio file not found in $AUDIO_DIR: $filename"
                echo "Run 'faahh --list' to see available audio files."
                return 1
            fi
            ;;
        ""|-h|--help)
            echo "Usage: faahh [--start | --stop | --list | --<file>.mp3]"
            echo "  --start       Enable playing audio on command not found"
            echo "  --stop        Disable playing audio on command not found"
            echo "  --list        List available audio files"
            echo "  --filename.mp3     Switch to a specific audio file in the audio folder"
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run 'faahh --help' for usage."
            return 1
            ;;
    esac
}

# For ZSH
if [ -n "$ZSH_VERSION" ]; then
    command_not_found_handler() {
        echo "zsh: command not found: $1" >&2
        local audio="${FAAHH_AUDIO_FILE:-$AUDIO_DIR/$DEFAULT_AUDIO_NAME}"
        if [ "$FAAHH_ENABLED" -eq 1 ] && [ -f "$audio" ]; then
            # afplay is the built-in audio player on macOS
            afplay "$audio" &
        fi
        return 127
    }
fi

# For BASH
if [ -n "$BASH_VERSION" ]; then
    command_not_found_handle() {
        echo "bash: $1: command not found" >&2
        local audio="${FAAHH_AUDIO_FILE:-$AUDIO_DIR/$DEFAULT_AUDIO_NAME}"
        if [ "$FAAHH_ENABLED" -eq 1 ] && [ -f "$audio" ]; then
            afplay "$audio" &
        fi
        return 127
    }
fi
