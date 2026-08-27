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
export LSCOLORS="Exfxcxdxcxegedabagacad"  # directories: bold/bright blue (default is dark blue)

# ----------------------------------------------------------
# VimWiki
# ----------------------------------------------------------
# On the Mac, VimWiki lives in Dropbox (synced across devices).
# On Lambda nodes it defaults to ~/vimwiki (set in vimrc).
export VIMWIKI_PATH="$HOME/Dropbox/vimwiki"

# ----------------------------------------------------------
# Antigravity (IDE + CLI)
# ----------------------------------------------------------
# The Antigravity apps append their PATH lines to ~/.zshrc on install
# and update. They are kept here instead: the paths are macOS-only and
# would be dead entries on the Lambda and ALCF nodes. If an update adds
# them back to zsh/zshrc, delete them there.
#
# The test is -x on the launcher, not -d on the directory. Both bin
# directories exist and contain symlinks into /Applications, but an app
# update can move the target and leave the symlink broken. That is the
# current state of ~/.antigravity: Antigravity.app 2.0.10 was replaced
# by Antigravity IDE.app 2.1.1, which dropped the app/bin directory the
# symlinks point to. -d would add a directory of broken symlinks to
# PATH; -x adds the entry only when the launcher is executable.
[[ -x "$HOME/.antigravity/antigravity/bin/antigravity" ]] && \
    export PATH="$HOME/.antigravity/antigravity/bin:$PATH"          # agy, antigravity
[[ -x "$HOME/.antigravity-ide/antigravity-ide/bin/antigravity-ide" ]] && \
    export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"  # agy-ide, antigravity-ide
