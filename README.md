# Faahh

This project is a fun, lightweight bash/zsh script for macOS that plays an audio file (from the `audio/` folder, e.g. `fah.mp3`) whenever you enter an invalid command in your terminal. 

## How it works

Modern shells (like `zsh` and `bash`) allow overriding the behavior of the terminal when a command is not found by defining a specific function (`command_not_found_handler` in Zsh and `command_not_found_handle` in Bash).

This script hooks into those functions to play your custom audio file (using Apple's built-in `afplay` command-line audio player) along with returning the standard error message. 

## Installation

We've provided a simple installer script to set everything up automatically. 

1. Open your terminal and navigate to the folder where you saved this project.
2. Place your `.mp3` files in the `audio/` folder in the project (for example `audio/fah.mp3`, `audio/bkl.mp3`, etc.).
3. Run the installer via `make`:
```bash
make faahh
```

The script will automatically configure the audio folder and add the necessary setup to your shell configuration file (`~/.zshrc` or `~/.bash_profile`).

4. Restart your terminal, or reload your configuration as prompted by the installer.


## Usage

Once installed, simply type a random invalid command like `asdfghjkl` or `sudo make me a sandwich` in your terminal. You should see the standard "command not found" error message and hear the audio play in the background!

### Controlling Playback & Audio

You can control Faahh and switch between available audio files using the `faahh` command:

```bash
faahh --stop       # Disables the audio playing on error
faahh --start      # Re-enables the audio playing on error
faahh --list       # Lists all available .mp3 files in the audio folder
faahh --filename.mp3    # Switches to the 'filename.mp3' audio file (or any other .mp3 in the audio folder)
```

To add new sounds in the future, simply drop additional `.mp3` files into the `audio/` folder — they will automatically appear in `faahh --list` and can be selected with the `faahh --<filename>.mp3` command.
