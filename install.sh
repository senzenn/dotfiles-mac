#!/bin/bash

# Mac Dotfiles Installation Script
# This script installs dependencies and sets up all dotfiles with proper symlinks

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}
print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}
print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}
print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

backup_file() {
    local file="$1"
    if [[ -f "$file" && ! -L "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backing up existing $file to $backup"
        mv "$file" "$backup"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
    fi
    backup_file "$target"
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    ln -sf "$source" "$target"
    print_success "Created symlink: $target -> $source"
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status "Starting dotfiles installation from $SCRIPT_DIR"

# 1. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    print_status "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    print_status "Homebrew already installed."
fi

# 2. Install essential packages
BREW_PACKAGES=(git zsh neovim tmux ripgrep fd fzf bat exa starship stow)
print_status "Installing essential Homebrew packages..."
brew install "${BREW_PACKAGES[@]}"

# 3. Install Oh My Zsh if not present
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_status "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    print_status "Oh My Zsh already installed."
fi

# 4. Install Zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 5. Set up stow for dotfiles
print_status "Setting up stow for dotfiles..."
cd "$SCRIPT_DIR"

# Create .stow-local-ignore if it doesn't exist
if [[ ! -f ".stow-local-ignore" ]]; then
    cat > .stow-local-ignore << 'EOF'
# Ignore git repositories and other unnecessary files
.git/
.gitignore
README.md
install.sh
setup.sh
*.md
.DS_Store
EOF
fi

# Stow all configurations
print_status "Stowing configurations..."
stow -t "$HOME" zsh
stow -t "$HOME" tmux
stow -t "$HOME" git
stow -t "$HOME" skhd
stow -t "$HOME" wezterm
stow -t "$HOME" zellij
stow -t "$HOME" nushell
stow -t "$HOME" ssh

# Stow config directories
mkdir -p "$HOME/.config"
stow -t "$HOME/.config" kitty
stow -t "$HOME/.config" nvim
stow -t "$HOME/.config" starship
stow -t "$HOME/.config" karabiner
stow -t "$HOME/.config" sketchybar
stow -t "$HOME/.config" nix
stow -t "$HOME/.config" nix-darwin

# 6. Install Neovim plugins
if command -v nvim &> /dev/null; then
    print_status "Installing Neovim plugins..."
    nvim --headless -c "Lazy! sync" -c "qa"
fi

print_success "Dotfiles installation and dependency setup completed!"
print_status "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
print_status "Kitty terminal configuration has been stowed to ~/.config/kitty/" 