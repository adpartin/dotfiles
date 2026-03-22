# Dotfiles

Personal dotfiles for Zsh, Vim, tmux, and Git. Designed to work across multiple systems without sudo.

## Systems

| System | Hostname pattern | System file |
|--------|-----------------|-------------|
| Lambda GPU nodes | `*lambda*` | `system/gpu-node.zsh` |
| Polaris (ALCF) | `*polaris*` | `system/polaris.zsh` |
| Aurora (ALCF) | `*aurora*` | `system/aurora.zsh` |
| MacBook | `darwin*` (OSTYPE) | `system/macos.zsh` |

Unknown systems get the base config with no system-specific file.

## Quick install

```sh
# 1. Clone the repo
git clone https://github.com/adpartin/dotfiles.git ~/dotfiles
cd ~/dotfiles
git checkout redesign

# 2. Run the installer (backs up existing dotfiles, creates symlinks, installs tools)
bash ~/dotfiles/install.sh

# 3. Restart your shell
exec zsh -l

# 4. Install Vim plugins
vim +PlugInstall +qall

# 5. Install tmux plugins (inside tmux)
# Press: Ctrl-a + I
```

The installer is idempotent — safe to run multiple times. Existing dotfiles are backed up to `~/.dotfiles-backup-<timestamp>/`.

## What gets installed

All tools install into `$HOME` (no sudo required):

| Tool | Purpose | Location |
|------|---------|----------|
| [Antidote](https://getantidote.github.io) | Zsh plugin manager (replaces Oh My Zsh) | `~/.antidote/` |
| [Starship](https://starship.rs) | Cross-shell prompt | `~/.local/bin/starship` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder (shell + Vim) | `~/.fzf/` |
| [vim-plug](https://github.com/junegunn/vim-plug) | Vim plugin manager | `~/.vim/autoload/plug.vim` |
| [tpm](https://github.com/tmux-plugins/tpm) | tmux plugin manager | `~/.tmux/plugins/tpm/` |

## Repo structure

```
~/dotfiles/
├── install.sh               # Idempotent installer (no sudo)
├── README.md
├── zsh/
│   ├── zshrc                # Main Zsh config → symlinked to ~/.zshrc
│   ├── aliases.zsh          # Aliases (sourced by zshrc)
│   ├── functions.zsh        # Shell functions (sourced by zshrc)
│   └── plugins.txt          # Antidote plugin list
├── vim/
│   └── vimrc                # Vim config → symlinked to ~/.vimrc
├── tmux/
│   └── tmux.conf            # tmux config → symlinked to ~/.tmux.conf
├── starship/
│   └── starship.toml        # Starship prompt → symlinked to ~/.config/starship.toml
├── git/
│   └── gitconfig            # Git config → symlinked to ~/.gitconfig
└── system/
    ├── gpu-node.zsh          # Lambda GPU nodes
    ├── polaris.zsh           # Polaris (ALCF)
    ├── aurora.zsh            # Aurora (ALCF)
    └── macos.zsh             # MacBook
```

## Symlinks

The installer creates these symlinks:

```
~/.zshrc                  → ~/dotfiles/zsh/zshrc
~/.vimrc                  → ~/dotfiles/vim/vimrc
~/.tmux.conf              → ~/dotfiles/tmux/tmux.conf
~/.gitconfig              → ~/dotfiles/git/gitconfig
~/.config/starship.toml   → ~/dotfiles/starship/starship.toml
```

Editing `~/.zshrc` edits the repo file directly. Changes are tracked by git.

## How the zshrc works

The zshrc loads in this order:

1. Ghostty terminfo fallback (passive unless SSH'ing from Ghostty)
2. Terminal / `$TERM` setup
3. History settings
4. Editor (`vim`)
5. PATH (`~/.local/bin`)
6. Antidote plugins (from `zsh/plugins.txt`)
7. Completion (with menuselect vim keys)
8. Vi mode keybindings
9. Starship prompt (falls back to built-in prompt if not installed)
10. fzf keybindings (Ctrl-R, Ctrl-T, Alt-C)
11. Conda — **lazy-loaded** (see below)
12. NVM — **lazy-loaded** (see below)
13. System-specific config (matched by hostname)
14. Aliases and functions
15. `~/.zshrc.local` (machine-specific overrides, not tracked in git)

### Lazy-loading

Conda and NVM are wrapped in shell functions that defer their expensive initialization (~2s each) until first use. When you type `conda activate myenv` or `node --version`, the wrapper runs the real init, removes itself, and forwards your command. Shell startup stays fast.

## Local overrides

Two files for machine-specific settings that should NOT be committed:

- **`~/.zshrc.local`** — sourced at the end of zshrc. Use for env vars, tokens, machine-specific aliases.
- **`~/.gitconfig.local`** — included via `[include]` in gitconfig. Use for `safe.directory`, alternate email, etc.

Create them as needed. They are gitignored.

## Adding a new system

1. Determine the hostname pattern (run `hostname -f` on the system)
2. Create `system/<name>.zsh` with system-specific settings
3. Add a hostname match in `zsh/zshrc` in the system detection section:
   ```zsh
   elif [[ "$_hostname" == *"<pattern>"* ]]; then
       _sys_file="$DOTFILES_DIR/system/<name>.zsh"
   ```
4. Commit and push

## Key bindings

### Shell (Zsh)

| Key | Action |
|-----|--------|
| `Ctrl-R` | Fuzzy search command history (fzf) |
| `Ctrl-T` | Fuzzy search files (fzf) |
| `Alt-C` | Fuzzy cd into directory (fzf) |
| `Esc` | Enter vi normal mode |
| `hjkl` | Navigate completion menu |

### Vim (leader = `,`)

| Key | Action |
|-----|--------|
| `,w` | Save |
| `,q` | Quit |
| `,r` | Search & replace |
| `,g` | Go to definition (ALE) |
| `,b` | List buffers (fzf) |
| `,l` | Search lines in buffer (fzf) |
| `Ctrl-f` | Find files (fzf) |
| `Ctrl-n` | Toggle NERDTree |
| `Tab` / `S-Tab` | Next / prev buffer |
| `Q` | Close buffer |
| `Space` | Toggle fold |
| `H` / `L` | Start / end of line |
| `J` / `K` | Move 5 lines down / up |
| `jk` or `kj` | Escape (insert mode) |

### tmux (prefix = `Ctrl-a`)

| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontally |
| `prefix + _` | Split vertically |
| `prefix + r` | Reload config |
| `prefix + c` | New window |
| `prefix + K` | Kill session (switch to next) |
| `prefix + j` | Join pane from another window |
| `prefix + s` | Swap panes |
| `prefix + [` | Enter copy mode |
| `prefix + I` | Install tmux plugins |
| `C-h/j/k/l` | Navigate panes (no prefix, works in Vim too) |

## Shell aliases

| Alias | Command |
|-------|---------|
| `gst` | `git status` |
| `gl` | `git log --oneline --graph` |
| `coac` | `conda activate` |
| `codea` | `conda deactivate` |
| `sz` | `source ~/.zshrc` |
| `vw` | Open VimWiki |
| `la` | `ls -la` |
| `ll` | `ls -l` |
| `..` | `cd ..` |
| `...` | `cd ../..` |
