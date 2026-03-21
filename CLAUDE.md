# Dotfiles Project Context

## What this is

Personal dotfiles repo using clone+symlinks pattern (not bare repo). The `redesign` branch is the active development branch. The old bare-repo setup at `~/.dotfiles` still exists as a safety net on GPU nodes.

## Architecture

- `install.sh` creates symlinks from `~/dotfiles/<tool>/<config>` → `~/.<config>` and installs dependencies (Antidote, Starship, fzf, vim-plug, tpm) in user-space (no sudo on remote systems).
- `zsh/zshrc` is modular: sources `aliases.zsh`, `functions.zsh`, system-specific files, and `~/.zshrc.local`.
- System detection uses hostname patterns: `*lambda*` → gpu-node.zsh, `*polaris*` → polaris.zsh, `*aurora*` → aurora.zsh, `darwin*` → macos.zsh.
- Conda and NVM are lazy-loaded (wrapper functions that init on first use) to keep shell startup fast.
- `~/.zshrc.local` and `~/.gitconfig.local` hold machine-specific settings not tracked in git.

## Target systems

1. Lambda GPU nodes (lambda0, etc.) — validated and working
2. MacBook (Apple M1 Max) — next to set up
3. Polaris (ALCF HPC) — future
4. Aurora (ALCF HPC) — future

## Key decisions

- Antidote replaces Oh My Zsh (only 4 plugins needed)
- vim-plug for Vim (already was in use, no migration)
- Starship prompt (single binary, no sudo)
- Ghostty terminfo fallback is in zshrc (passive until needed)
- Phase 4 (removing old bare repo `~/.dotfiles`) is deferred until validated on at least 2 systems

## User preferences

- Prefers Vim over Neovim
- Uses vi mode in shell and Vim (leader key is comma)
- Values clarity over cleverness — prefers explicit comments explaining what things do
- Wants to play safe — don't remove old configs until new setup is validated
- No sudo on remote systems, everything installs to $HOME
- Ask before removing any existing settings

## When helping with this repo

- At the start of a session, run `hostname` and `uname -s` to identify which system you're on. This determines which `system/*.zsh` file applies and what's available (sudo, Homebrew, module system, etc.).
- Read the relevant config file before suggesting changes
- Every setting must be ported or explicitly documented as intentionally removed
- Test incrementally — build one file, test it, move on
- System-specific settings go in `system/*.zsh`, not in the main zshrc or aliases
- MacBook setup: `system/macos.zsh` needs to be populated (Homebrew PATH, macOS-specific settings, VimWiki path points to Dropbox)
