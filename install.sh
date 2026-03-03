#!/bin/bash

echo "Installing Faahh..."

# Get the directory where this script is located
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SCRIPT_PATH="$INSTALL_DIR/faahh.sh"
AUDIO_PATH="$INSTALL_DIR/fahhhhh.mp3"

# Check if the audio file exists
if [ ! -f "$AUDIO_PATH" ]; then
    echo "Error: Audio file not found at $AUDIO_PATH"
    echo "Please make sure fahhhhh.mp3 is in the same directory as this installer."
    exit 1
fi

# Update the audio path in faahh.sh automatically
echo "Configuring faahh.sh with absolute paths..."
sed -i '' "s|AUDIO_FILE=.*|AUDIO_FILE=\"$AUDIO_PATH\"|" "$SCRIPT_PATH"

echo "Adding Faahh to your shell configuration..."

# Add to Zsh configuration if it exists
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.zshrc"; then
        echo "echo 'source \"$SCRIPT_PATH\"' >> ~/.zshrc" >> "$HOME/.zshrc"
        echo "Added to ~/.zshrc"
    else
        echo "Faahh is already installed in ~/.zshrc"
    fi
fi

# Add to Bash configuration if it exists
if [ -f "$HOME/.bash_profile" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.bash_profile"; then
        echo "echo 'source \"$SCRIPT_PATH\"' >> ~/.bash_profile" >> "$HOME/.bash_profile"
        echo "Added to ~/.bash_profile"
    else
        echo "Faahh is already installed in ~/.bash_profile"
    fi
elif [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "$SCRIPT_PATH" "$HOME/.bashrc"; then
        echo "echo 'source \"$SCRIPT_PATH\"' >> ~/.bashrc" >> "$HOME/.bashrc"
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
