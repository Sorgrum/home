#!/usr/bin/env zsh

# powerlevel10k

P10K_DIR=~/.powerlevel10k
if [ ! -d $P10K_DIR ]; then 
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10K_DIR
    echo "Powerlevel10k theme installed."
fi

# additional dependencies

function has() {
    which "$@" > /dev/null 2>&1
}

if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "Installing dependencies..."
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
