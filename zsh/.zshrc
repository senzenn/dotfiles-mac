# ------------ Fast Powerlevel10k Instant Prompt ------------
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# ---------------- Zinit (Zsh Plugin Manager) ---------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
export GEMINI_API_KEY="AIzaSyD6DxVqxnvE2gNLYfDGnIlKYTfqKIb3XlY"
export GOOGLE_GENAI_USE_VERTEXAI=true
# -------------- Zinit Plugins & Powerlevel10k --------------
# zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# ------------- Prompt System Selection -------------
unset ZSH_THEME
# Enable ONLY ONE of the following:
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh          # Powerlevel10k prompt
eval "$(starship init zsh)"                             # Starship prompt

# ------------ History, Keymap & Interactive Options -------------
setopt autocd correct interactivecomments  nonomatch notify numericglobsort promptsubst
bindkey -v
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ------------------- Editor and PATH Setup ---------------------
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.config/solana/install/active_release/bin:$PATH"
export SOLANA_CLI_CONFIG="$HOME/.config/solana/cli/config.yml"
export NODE_ENV=development
export PATH="./node_modules/.bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export PYTHONPATH="$HOME/.local/lib/python3.11/site-packages:$PYTHONPATH"
export NERDFONT_ICONS=true

# ------------------ FZF (fuzzy finder) options -----------------
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="--info=inline-right --ansi --layout=reverse --border=rounded"
fi

# ----- Development Tooling: Terraform, Docker, Kubernetes ------
if command -v terraform >/dev/null 2>&1; then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  mkdir -p "$TF_PLUGIN_CACHE_DIR"
fi
if command -v docker >/dev/null 2>&1; then
  export DOCKER_BUILDKIT=1
  export COMPOSE_DOCKER_CLI_BUILD=1
fi
if command -v kubectl >/dev/null 2>&1; then
  export KUBECONFIG="$HOME/.kube/config"
  if command -v kubectx >/dev/null 2>&1; then
    export KUBECTX_IGNORE_FZF=1
  fi
fi
if command -v gh >/dev/null 2>&1; then
  export GH_CONFIG_DIR="$HOME/.config/gh"
fi
if command -v yazi >/dev/null 2>&1; then
  export YAZI_THEME_DIR="$HOME/.config/yazi/themes"
fi

# ---------------- LS, EZA, LSD and Colored Listings ------------
if command -v eza >/dev/null 2>&1; then
  # Enhanced 'ls' with eza; aliases set below
  :
else
  alias ll='ls -lah'
  alias la='ls -A'
  alias l='ls -CF'
fi

# ---------------- Shortcuts, Useful Aliases -------------------
alias treew='tree -I "node_modules|.git"'
alias c='clear'
alias vi='nvim'
alias gs='git status'; alias ga='git add'; alias gc='git commit'; alias gl='git pull'
alias ..='cd ..'; alias ...='cd ../..'
# Kubernetes
alias k='kubectl'; alias kg='kubectl get'; alias kd='kubectl describe'; alias kl='kubectl logs'
alias ka='kubectl apply'; alias kx='kubectl exec -it'
# Docker
alias d='docker'; alias dc='docker-compose'; alias dps='docker ps'; alias di='docker images'; alias dex='docker exec -it'
# Terraform
alias tf='terraform'; alias tfi='terraform init'; alias tfp='terraform plan'
alias tfa='terraform apply'; alias tfd='terraform destroy'
# GitHub CLI
alias ghpr='gh pr create'; alias ghprv='gh pr view'; alias ghprl='gh pr list'
# System monitoring
alias top='htop'; alias sys='btop'
# File operations
alias cat='bat'; alias find='fd'; alias grep='rg'
alias ls='eza --icons --git'
alias ll='eza --icons -la --header --git --group-directories-first'
alias la='eza --icons -a --git'
alias l='eza --icons -F --git'
alias tree='eza --tree --icons --git'
# Git enhanced
alias lg='lazygit'; alias gst='git status'; alias gco='git checkout'; alias gcb='git checkout -b'
alias gp='git push'; alias gpl='git pull'; alias gd='git diff'; alias gdc='git diff --cached'
alias glog='git log --oneline --graph --decorate'
# Rust
alias cr='cargo run'; alias cb='cargo build'; alias cbr='cargo build --release'
alias ct='cargo test'; alias cc='cargo check'; alias cf='cargo fmt'; alias cl='cargo clippy'
# Solana
alias sol='solana'; alias solb='solana balance'; alias solv='solana validators'
alias sold='solana deploy'; alias solpk='solana-keygen'
# Next.js/React
alias nr='npm run'; alias nrd='npm run dev'; alias nrb='npm run build'; alias nrs='npm run start'

# ------------- FZF + Bat for Better Manpages ------------------
if [[ -x "$(command -v bat)" ]]; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# ------------- zoxide (better cd) -----------------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ------ Enhanced cd: lists directory after entering ------------
function cd() {
  builtin cd "$@" || return
  if command -v eza >/dev/null 2>&1; then
    eza --icons -F
  else
    ls
  fi
}

# ------------- Load FZF keybinds ------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------- Completions ------------------------------------
autoload -Uz compinit && compinit -i

# --- Powerlevel10k Quiet Mode (recommended for instant prompt) --
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ------------ Fastfetch at login (avoid tmux, repeated shells) -
if [[ $- == *i* && ! $TMUX && -z "$FASTFETCH_LOADED" ]]; then
  if command -v fastfetch >/dev/null 2>&1; then
    export FASTFETCH_LOADED=1
    fastfetch
  fi
fi

# ------------ Autostart Tmux unless already running ------------
if command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" ]]; then
  tmux new-session -A -s main
fi


# opencode
export PATH=/Users/senzenn/.opencode/bin:$PATH

# >>> Starship prompt initialization >>>
eval "$(starship init zsh)"
# <<< Starship prompt initialization <<<
