# Mac Dotfiles

A comprehensive collection of dotfiles for macOS development environment.

## What's Included

- **Shell**: Zsh configuration with Oh My Zsh and custom aliases
- **Editor**: Neovim configuration with plugins and keybindings
- **Terminal**: Tmux configuration with sessions and window management
- **Git**: Git configuration and aliases
- **Homebrew**: Package management setup
- **macOS**: System preferences and defaults

## Installation

### Prerequisites

1. Install Homebrew (if not already installed):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install required packages:
```bash
brew install git zsh neovim tmux ripgrep fd fzf bat exa
```

3. Install Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Quick Setup

Run the installation script:
```bash
./install.sh
```

### Manual Setup

1. Clone this repository:
```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

2. Create symlinks:
```bash
# Zsh
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/.zsh_aliases ~/.zsh_aliases
ln -sf ~/.dotfiles/zsh/.zsh_functions ~/.zsh_functions

# Neovim
ln -sf ~/.dotfiles/nvim ~/.config/nvim

# Tmux
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Git
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# Other configs
ln -sf ~/.dotfiles/other/.inputrc ~/.inputrc
```

## Features

### Zsh
- Oh My Zsh with Powerlevel10k theme
- Custom aliases and functions
- Syntax highlighting and autosuggestions
- FZF integration

### Neovim
- LSP support for multiple languages
- Tree-sitter syntax highlighting
- Telescope for fuzzy finding
- Lazy.nvim plugin manager
- Custom keybindings

### Tmux
- Session persistence
- Custom status bar
- Easy window and pane management
- Integration with Neovim

### Git
- Global configuration
- Useful aliases
- Global gitignore

## Customization

Each configuration file is well-commented and organized. Feel free to modify them according to your preferences.

## Maintenance

- Update plugins regularly
- Keep Homebrew packages updated
- Review and update aliases as needed

## License

MIT License - feel free to use and modify as needed. # dotfiles-mac
