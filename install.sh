#!/usr/bin/env bash
#
# Dotfiles installer — idempotent (skips if already installed) and user-space (no sudo required).
# Usage: bash ~/dotfiles/install.sh
#

# -e: exit immediately if any command fails
# -u: treat unset variables as errors
# -o pipefail: a pipeline fails if any command in it fails (not just the last one)
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# -------------------------------------------------------
# Helpers — colored output for readability
# -------------------------------------------------------
# \033[1;34m = bold blue, \033[0m = reset color
info()  { printf "\033[1;34m[info]\033[0m  %s\n" "$1"; }
warn()  { printf "\033[1;33m[warn]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[ok]\033[0m    %s\n" "$1"; }
err()   { printf "\033[1;31m[error]\033[0m %s\n" "$1"; exit 1; }

# backup_and_link: safely create a symlink from $dst → $src.
# If $dst already exists (old dotfile), move it to the backup dir first.
# If $dst is already the correct symlink, do nothing (idempotent).
backup_and_link() {
    local src="$1"   # source file in ~/dotfiles/  (e.g., ~/dotfiles/zsh/zshrc)
    local dst="$2"   # target path in $HOME        (e.g., ~/.zshrc)

    # -L tests if $dst is a symlink; readlink resolves where it points
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        ok "Already linked: $dst → $src"
        return
    fi

    # If something exists at destination, back it up.
    # -e tests if file exists; -L tests if it's a symlink (even a broken one).
    # We check both because -e returns false for broken symlinks.
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
        warn "Backed up: $dst → $BACKUP_DIR/$(basename "$dst")"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    ln -s "$src" "$dst"
    ok "Linked: $dst → $src"
}

# -------------------------------------------------------
# Preflight
# -------------------------------------------------------
if [ ! -d "$DOTFILES_DIR" ]; then
    err "$DOTFILES_DIR does not exist. Clone the repo first."
fi

info "Installing dotfiles from $DOTFILES_DIR"
echo ""

# -------------------------------------------------------
# 1. Symlinks
# -------------------------------------------------------
# This is the core of the dotfiles setup. Instead of copying config files
# into $HOME, we create symlinks that point back to our repo. This way:
#   - Editing ~/.zshrc actually edits ~/dotfiles/zsh/zshrc
#   - Changes are automatically tracked by git
#   - `git diff` in ~/dotfiles shows exactly what changed
info "Creating symlinks..."

backup_and_link "$DOTFILES_DIR/zsh/zshrc"       "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/vim/vimrc"        "$HOME/.vimrc"
backup_and_link "$DOTFILES_DIR/tmux/tmux.conf"   "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/git/gitconfig"     "$HOME/.gitconfig"

echo ""

# -------------------------------------------------------
# 2. Antidote (Zsh plugin manager)
# -------------------------------------------------------
# Antidote replaces Oh My Zsh. It's a lightweight Zsh plugin manager
# that reads a list of plugins from zsh/plugins.txt and clones them.
# https://getantidote.github.io
info "Installing Antidote..."

ANTIDOTE_DIR="$HOME/.antidote"
if [ -d "$ANTIDOTE_DIR" ]; then
    ok "Antidote already installed at $ANTIDOTE_DIR"
else
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
    ok "Antidote installed at $ANTIDOTE_DIR"
fi

echo ""

# -------------------------------------------------------
# 3. Starship prompt
# -------------------------------------------------------
# Starship is a cross-shell prompt that shows useful context
# (git branch, conda env, etc.) with zero config. It's a single
# static binary — no runtime dependencies, no sudo needed.
# https://starship.rs
info "Installing Starship..."

STARSHIP_BIN="$HOME/.local/bin/starship"
if [ -x "$STARSHIP_BIN" ]; then
    ok "Starship already installed at $STARSHIP_BIN"
else
    mkdir -p "$HOME/.local/bin"
    # Starship provides an install script that supports BIN_DIR for non-root installs
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" --yes
    if [ -x "$STARSHIP_BIN" ]; then
        ok "Starship installed at $STARSHIP_BIN"
    else
        warn "Starship installation failed. Prompt will fall back to a basic built-in prompt."
    fi
fi

echo ""

# -------------------------------------------------------
# 4. fzf (fuzzy finder)
# -------------------------------------------------------
# fzf provides fuzzy search for the shell and Vim:
#   - Shell: Ctrl-R (history search), Ctrl-T (file search), Alt-C (cd into dir)
#   - Vim:   :Files, :Buffers, :BLines (via fzf.vim plugin)
# https://github.com/junegunn/fzf
info "Installing fzf..."

FZF_DIR="$HOME/.fzf"
if [ -d "$FZF_DIR" ]; then
    ok "fzf already installed at $FZF_DIR"
else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
    # --key-bindings:  enable Ctrl-R/Ctrl-T/Alt-C shell keybindings
    # --completion:    enable **<tab> fuzzy path completion
    # --no-update-rc:  don't append sourcing lines to .zshrc (we handle that ourselves)
    # --no-bash/fish:  only install zsh integration
    "$FZF_DIR/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
    ok "fzf installed at $FZF_DIR"
fi

echo ""

# -------------------------------------------------------
# 5. vim-plug (Vim plugin manager)
# -------------------------------------------------------
# vim-plug manages Vim plugins listed in vimrc between
# plug#begin() and plug#end(). After installing vim-plug itself,
# run :PlugInstall inside Vim to install the plugins.
# https://github.com/junegunn/vim-plug
info "Installing vim-plug..."

PLUG_VIM="$HOME/.vim/autoload/plug.vim"
if [ -f "$PLUG_VIM" ]; then
    ok "vim-plug already installed at $PLUG_VIM"
else
    # -f: fail silently on HTTP errors  -L: follow redirects  -o: output file
    # --create-dirs: create ~/.vim/autoload/ if it doesn't exist
    curl -fLo "$PLUG_VIM" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ok "vim-plug installed at $PLUG_VIM"
fi

echo ""

# -------------------------------------------------------
# 6. tmux plugin manager (tpm)
# -------------------------------------------------------
# tpm manages tmux plugins listed in tmux.conf (set -g @plugin '...').
# After installing tpm itself, press prefix + I inside tmux to install plugins.
# https://github.com/tmux-plugins/tpm
info "Installing tpm..."

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    ok "tpm already installed at $TPM_DIR"
else
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
    ok "tpm installed at $TPM_DIR"
fi

echo ""

# -------------------------------------------------------
# Summary
# -------------------------------------------------------
echo "========================================"
info "Installation complete."
if [ -d "$BACKUP_DIR" ]; then
    warn "Backups saved to: $BACKUP_DIR"
fi
echo ""
info "Next steps:"
echo "  1. Restart your shell:  exec zsh -l"
echo "  2. Install Vim plugins: vim +PlugInstall +qall"
echo "  3. Install tmux plugins: prefix + I (inside tmux)"
echo "========================================"
