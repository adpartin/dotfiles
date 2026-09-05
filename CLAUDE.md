# Dotfiles Repository Guide

## Purpose

This is a personal dotfiles repository for several systems. It uses a normal Git checkout
and symlinks, not a bare repository. `install.sh` expects the checkout at `~/dotfiles`,
backs up existing dotfiles, creates the symlinks, and installs user-space tools.

An older bare-repository setup still exists at `~/.dotfiles` on the Lambda GPU nodes.
Keep it as a safety net unless the user explicitly asks to remove it.

## Layout

- `zsh/zshrc` loads the shared shell setup, aliases, functions, system config, and
  `~/.zshrc.local`.
- macOS is detected with `$OSTYPE`. Lambda, Polaris, and Aurora are detected by hostname
  and load the matching file from `system/`.
- Conda and NVM load only when first used to keep shell startup fast.
- Machine-specific settings belong in `~/.zshrc.local` or `~/.gitconfig.local`. These
  files are not tracked.
- One-time software setup, including Codex and OpenCode, is documented in
  `system/README.md`.

## System status

- Lambda GPU nodes: validated and working.
- MacBook (Apple M1 Max): validated and working.
- Polaris: configuration is written; validation on Polaris is still pending.
- Aurora: placeholder only; setup is still pending.

## Working rules

- Read the relevant files before suggesting or making changes.
- Check `hostname -f` and `uname -s` before changing system-specific behavior.
- Put system-specific settings in `system/*.zsh`, not in shared aliases or `zsh/zshrc`.
- During migrations, preserve existing behavior or clearly document intentional removals.
- Avoid sudo on remote systems and prefer user-space installs.
- Do not remove old settings, backups, or the bare repository without explicit approval.
- Prefer Vim over Neovim. Keep vi mode; the Vim leader key is comma.
- Use plain language and comment only behavior that is not obvious.
- Run focused checks after changes. For example, use `zsh -n zsh/zshrc` for Zsh syntax
  and `git diff --check` for patch formatting.
