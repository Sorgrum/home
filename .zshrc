# zshrc

# Path

path=(
    $path
    ~/.cargo/bin
)

# Command: has
# Description: Check if a command exists

function has() {
    which "$@" > /dev/null 2>&1
}

# Enable auto-completion
autoload -Uz compinit
compinit

# Set Default Editor

if has nvim ; then
    export EDITOR=nvim
    export GIT_EDITOR=nvim
elif has vim ; then
    export EDITOR=vim
    export GIT_EDITOR=vim
fi

# Git Aliases

if has git ; then
    alias g='git'
    alias gs='git status'
    alias gf='git fetch'
    alias ga='git add'
    alias gc='git commit'
    alias hawk='git'
fi

# File Handling Aliases

alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}'

# Command Aliases

if has bat ; then
    alias cat='bat'
elif has batcat ; then
    alias cat='batcat'
fi
if has eza ; then
    alias ls='eza'
fi
if has nvim ; then
    alias vim="nvim"
fi

if has et ; then
    autoload colors; colors
    function ssh() {
        # Attempt to connect using EternalTerminal
        et "$@" 
        if [ $? -ne 0 ]; then
            echo $fg[yellow]Falling back to SSH$reset_color
            echo
            command ssh "$@"
        fi
    }
fi

# zsh-autosuggestions (macOS)
if has brew && [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Kubernetes
if has talosctl; then
    # Talos command completions
    source <(talosctl completion zsh)
fi

if has mise; then
    eval "$(mise activate zsh)"
fi

if has kubectl; then
    source <(kubectl completion zsh)
    source ~/.zsh_functions/pods.zsh

    alias kn='kubectl -n'
fi

# github-cli
if has gh; then
    autoload -U compinit
    compinit -i
fi

# History

HISTSIZE=1048576
SAVEHIST=$HISTSIZE
HISTFILE=~/.history_zsh

setopt interactivecomments      # Enable comments in interactive mode (useful)
setopt extended_glob            # More powerful glob features
setopt append_history           # Append to history on exit, don't overwrite it.
setopt extended_history         # Save timestamps with history
setopt hist_no_store            # Don't store history commands
setopt hist_save_no_dups        # Don't save duplicate history entries
setopt hist_ignore_all_dups     # Ignore old command duplicates (in current session)
setopt inc_append_history       # Don't immediately append to history
setopt no_share_history         # Don't share history between sessions

# Command: git-commit-in-branch
# Description: Check if a branch contains a commit

function git-commit-in-branch() {
    if [ $# -lt 2 ]; then 
        echo "Usage: $funcstack[1] <branch-name> <commit-hash>"
        return
    fi
    
    if git tag > /dev/null 2>&1; then
        git rev-list $1 | grep `git rev-parse $2`
    else
        echo "Must be used in a git repository"
        return
    fi
}

# Command: git-remove-local-branches
# Description: Remove local branches that have been deleted on the remote

function git-remove-local-branches() {
    if git tag > /dev/null 2>&1; then
        git fetch -p \
            && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); 
                do git branch -D $branch; 
            done
    else
        echo "Command must be run in git repository";
    fi
}

# starship.rs prompt 

if ! has starship; then
    echo "Starship not found. Installing..."
    curl -sS https://starship.rs/install.sh | sh
fi

if ! has starship; then
    echo "Starship installation failed. Please install it manually."
else
    # Use default starship config if local config is not found
    if [ ! -f ~/.config/starship.toml ]; then
        export STARSHIP_CONFIG=/etc/starship.toml
    fi
    eval "$(starship init zsh)"
fi

# SSH Agent setup

if [ -z "$SSH_AUTH_SOCK" ]; then
    # Check if we have a saved agent environment file
    if [ -f ~/.ssh/ssh-agent.env ]; then
        source ~/.ssh/ssh-agent.env > /dev/null
        if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
            # The saved agent is dead, start a new one
            ssh-agent > ~/.ssh/ssh-agent.env
            source ~/.ssh/ssh-agent.env > /dev/null
        fi
    else
        # No agent file exists, start a new one
        ssh-agent > ~/.ssh/ssh-agent.env
        source ~/.ssh/ssh-agent.env > /dev/null
    fi
    
fi


# Load local zshrc

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# Check if any SSH keys are loaded, show helpful message if not

if [ -n "$SSH_AUTH_SOCK" ] && ssh-add -l >/dev/null 2>&1; then
    : # Keys are loaded, do nothing
else
    echo "💡 No SSH keys loaded. Add 'ssh-add ~/.ssh/your_key 2>/dev/null' to ~/.zshrc_local to auto-load keys."
fi

# Fix keybindings in VSCode
bindkey -e
