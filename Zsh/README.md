# 🟡 ZSHrc file


Basic zsh configurations with practical aliases and common zsh plugins for a good zsh shell experience

Key Features:

- **Smart Detection:** Leverages expac for lightning-fast official package previews and paru for AUR package fallbacks.

- **Rich Metadata:** Displays icons, architecture, file sizes, dependencies, and the full list of files included in the package.

- **Advanced Aesthetics:** Implements color-coded borders (Blue for input, Green for the list, Magenta for the preview) with custom labels.

- **YAML Formatting:** Uses bat to apply syntax highlighting to the package details for better readability.

## Ubuntu & Debian Derivatives

Please note that the configuration differs for Debian-based systems. You will need to install specific dependencies and perform an initial setup:

- **Install Dependencies:** Install **`apt-file`** and **`bat`** using the following command:
```bash
    sudo apt update && sudo apt install apt-file bat
``` 

- **Update apt-file Database:** For the package preview features to function correctly, you must initialize the **`apt-file`** index:
```bash
    sudo apt-file update
``` 

- **Command Name Adjustment (batcat):** On these systems, the bat package installs the executable as batcat.

##  Requirements

Use of required plus signs:
-  [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
-  [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
-  [fzf](https://github.com/junegunn/fzf) / [fzf-tab](https://github.com/Aloxaf/fzf-tab)
-  [sudo](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/README.md)
-  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
-  [zoxide](https://github.com/ajeetdsouza/zoxide)
-  [expac]()

# 🟡 Pacman ZSH Theme

A custom theme inspired by Pacman aesthetics, featuring dynamic segments, Git integration, and Nerd Font icons.

## Features

-  Pacman-inspired design
-  Current directory display (last two directories)
-  Exit status indicator (shows when a command fails)
-  Git branch and status integration
-  Clean segmented powerline-style prompt

##  Requirements

-  [A Nerd Font (for icons to display properly)](https://www.nerdfonts.com/)
-  [async.zsh](https://github.com/mafredri/zsh-async)

##  Screenshots

![App Screenshot](https://raw.githubusercontent.com/shapzo/Dotfiles_BSPwm/refs/heads/BSPwm/Zsh/Screenshot-zsh_theme/Screen(1).png)

![App Screenshot](https://raw.githubusercontent.com/shapzo/Dotfiles_BSPwm/refs/heads/BSPwm/Zsh/Screenshot-zsh_theme/Screen(3).png)
