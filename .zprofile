if [ -d "/opt/homebrew/bin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh --shims)"
fi
