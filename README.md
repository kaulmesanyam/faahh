# Faahh

This project is a fun, lightweight bash/zsh script for macOS that plays an audio file (`fahhhhh.mp3`) whenever you enter an invalid command in your terminal. 

## How it works

Modern shells (like `zsh` and `bash`) allow overriding the behavior of the terminal when a command is not found by defining a specific function (`command_not_found_handler` in Zsh and `command_not_found_handle` in Bash).

This script hooks into those functions to play your custom audio file (using Apple's built-in `afplay` command-line audio player) along with returning the standard error message. 

## Installation

To make this active in your terminal every time you open it, you need to `source` this script in your shell configuration file.

### For Zsh (Default on newer Macs)
Open your terminal and run:
```bash
echo 'source <path to project>/faahh/faahh.sh' >> ~/.zshrc
source ~/.zshrc
```

### For Bash
Open your terminal and run:
```bash
echo 'source <path to project>/faahh/faahh.sh' >> ~/.bash_profile
source ~/.bash_profile
```

## Usage

Once installed, simply type a random invalid command like `asdfghjkl` or `sudo make me a sandwich` in your terminal. You should see the standard "command not found" error message and hear the audio play in the background!
