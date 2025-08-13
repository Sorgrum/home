#!/usr/bin/env zsh

CONFIG_BASE="$HOME/.config/zsh"

# powerlevel10k
P10K_DIR=$CONFIG_BASE/.powerlevel10k
if [ ! -f "$P10K_DIR/powerlevel10k.zsh-theme" ]; then 
    echo "Installing Powerlevel10k theme..."
    mkdir -p $P10K_DIR
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
    echo "Powerlevel10k theme installed."
else 
    echo "Powerlevel10k theme already installed."
fi

# zsh-autocomplete
ZSH_AUTOCOMPLETE_DIR=$CONFIG_BASE/.zsh-autocomplete
if [ ! -f "$ZSH_AUTOCOMPLETE_DIR/zsh-autocomplete.plugin.zsh" ]; then
    echo "Installing zsh-autocomplete..."
    mkdir -p $ZSH_AUTOCOMPLETE_DIR
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_AUTOCOMPLETE_DIR
    echo "zsh-autocomplete installed."
else
    echo "zsh-autocomplete already installed."
fi

# zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING_DIR=$CONFIG_BASE/.zsh-syntax-highlighting
if [ ! -f "$ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh" ]; then
    echo "Installing zsh-syntax-highlighting..."
    mkdir -p $ZSH_SYNTAX_HIGHLIGHTING_DIR
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
    echo "zsh-syntax-highlighting installed."
else
    echo "zsh-syntax-highlighting already installed."
fi

# additional dependencies

function has() {
    which "$@" > /dev/null 2>&1
}

if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "Installing brew dependencies..."
    brew install \
        bat \
        eza \
        nvim \
        git \
        nvim \
        zsh-autosuggestions \
        mise \
        MisterTea/et/et
else 
    echo "Unsupported OS. Please install dependencies manually."
fi
