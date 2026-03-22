# System config for MacBook (Apple Silicon)
# This file is sourced automatically when OSTYPE matches darwin*.
# See the "System detection" section in zsh/zshrc.

# ----------------------------------------------------------
# Homebrew
# ----------------------------------------------------------
# On Apple Silicon Macs, Homebrew installs to /opt/homebrew (not /usr/local).
# This adds its binaries, man pages, and completions to the shell.
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ----------------------------------------------------------
# ls coloring
# ----------------------------------------------------------
# macOS ls uses -G for color (not --color=auto like GNU/Linux ls).
# Override the GNU alias set in aliases.zsh.
alias ls="ls -G"

# ----------------------------------------------------------
# VimWiki
# ----------------------------------------------------------
# On the Mac, VimWiki lives in Dropbox (synced across devices).
# On Lambda nodes it defaults to ~/vimwiki (set in vimrc).
export VIMWIKI_PATH="$HOME/Dropbox/vimwiki"
