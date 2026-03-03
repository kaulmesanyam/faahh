#!/bin/bash

echo "Installing Faahh..."

# Get the directory where this script is located
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SCRIPT_PATH="$INSTALL_DIR/faahh.sh"
AUDIO_DIR="$INSTALL_DIR/audio"

echo "Checking audio directory at $AUDIO_DIR..."

# Ensure audio directory exists
if [ ! -d "$AUDIO_DIR" ]; then
    echo "Error: Audio directory not found at $AUDIO_DIR"
    echo "Please make sure the 'audio' folder exists in the project and contains your .mp3 files."
    exit 1
fi

# Ensure at least one .mp3 exists in the audio directory
if ! ls "$AUDIO_DIR"/*.mp3 >/dev/null 2>&1; then
    echo "Error: No .mp3 files found in $AUDIO_DIR"
    echo "Please add at least one .mp3 file (e.g. fahhhhh.mp3) to the 'audio' folder and re-run the installer."
    exit 1
fi

echo "Audio directory verified at $AUDIO_DIR"

echo "Adding Faahh to your shell configuration..."

# Add to Zsh configuration if it exists
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.zshrc"; then
        echo "source \"$SCRIPT_PATH\"" >> "$HOME/.zshrc"
        echo "Added to ~/.zshrc"
    else
        echo "Faahh is already installed in ~/.zshrc"
    fi
fi

# Add to Bash configuration if it exists
if [ -f "$HOME/.bash_profile" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.bash_profile"; then
        echo "source \"$SCRIPT_PATH\"" >> "$HOME/.bash_profile"
        echo "Added to ~/.bash_profile"
    else
        echo "Faahh is already installed in ~/.bash_profile"
    fi
elif [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.bashrc"; then
        echo "source \"$SCRIPT_PATH\"" >> "$HOME/.bashrc"
        echo "Added to ~/.bashrc"
    else
        echo "Faahh is already installed in ~/.bashrc"
    fi
fi

echo ""
echo "Installation complete!"
echo "Please restart your terminal or run the following command to apply changes immediately:"
echo ""
echo "For Zsh:  source ~/.zshrc"
echo "For Bash: source ~/.bash_profile  (or source ~/.bashrc)"
echo ""
