# Faahh

This project is a fun, lightweight bash/zsh script for macOS that plays an audio file (`fahhhhh.mp3`) whenever you enter an invalid command in your terminal. 

## How it works

Modern shells (like `zsh` and `bash`) allow overriding the behavior of the terminal when a command is not found by defining a specific function (`command_not_found_handler` in Zsh and `command_not_found_handle` in Bash).

This script hooks into those functions to play your custom audio file (using Apple's built-in `afplay` command-line audio player) along with returning the standard error message. 

## Installation

We've provided a simple installer script to set everything up automatically. 

1. Open your terminal and navigate to the folder where you saved this project.
2. Make the installer executable (if it isn't already) and run it:
```bash
chmod +x install.sh
./install.sh
```

The script will automatically configure the audio path and add the necessary setup to your shell configuration file (`~/.zshrc` or `~/.bash_profile`).

3. Restart your terminal, or reload your configuration as prompted by the installer.


## Usage

Once installed, simply type a random invalid command like `asdfghjkl` or `sudo make me a sandwich` in your terminal. You should see the standard "command not found" error message and hear the audio play in the background!

### Controlling Playback

You can easily enable or disable the audio playback at any time by using the `faahh` command:

```bash
faahh --stop   # Disables the audio playing on error
faahh --start  # Re-enables the audio playing on error
```
