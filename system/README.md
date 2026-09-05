# System-specific setup notes

Each system has a `.zsh` file that is auto-sourced based on hostname/OS detection in `zsh/zshrc`. This document covers one-time setup steps that go beyond `install.sh`.

## Lambda GPU nodes (gpu-node.zsh)

No extra setup needed. `install.sh` handles everything.

### Claude Code

```sh
# NVM + Node (if not already installed)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc  # or: export NVM_DIR="$HOME/.nvm" && . "$NVM_DIR/nvm.sh"
nvm install --lts

# Claude Code
npm install -g @anthropic-ai/claude-code
```

### SSH agent (avoid repeated passphrase prompts)

Add to `~/.zshrc.local`:

```sh
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2>/dev/null
fi
```

## MacBook (macos.zsh)

No extra setup needed beyond `install.sh`. Homebrew must be installed first (`/opt/homebrew`).

### Claude Code

```sh
# NVM + Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install --lts

# Claude Code
npm install -g @anthropic-ai/claude-code
```

## Polaris — ALCF HPC (polaris.zsh)

Polaris has 4 login nodes (polaris-login-01 through 04) sharing the same `$HOME`. Run `install.sh` once from any login node — symlinks are visible on all nodes.

### Conda

Conda is not available by default. It's loaded via the module system:

```sh
module use /soft/modulefiles
module load conda
conda activate
```

This is handled automatically in `polaris.zsh`.

### Claude Code

```sh
# NVM + Node (if not already installed)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts

# Claude Code
npm install -g @anthropic-ai/claude-code
```

NVM is lazy-loaded by `zshrc`, so after `install.sh`, `claude`, `node`, `npm`, and `npx` work automatically on all login nodes without manual NVM setup.

## Aurora — ALCF HPC (aurora.zsh)

Not yet set up.

## Codex CLI (all systems)

On these systems, Codex is installed as a standalone native binary rather than through
npm, so it needs neither Node nor NVM and keeps working if either is missing or broken.
The installer picks the build matching the machine's architecture, so this is the same
command on the Lambda nodes, the MacBook, and the HPC systems:

```sh
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

The installer reads two independent environment variables, both of which should normally
be left unset:

| Variable | Controls | Default |
| --- | --- | --- |
| `CODEX_HOME` | payload *and* state (auth, sessions, history) | `$HOME/.codex` |
| `CODEX_INSTALL_DIR` | the `codex` launcher symlink | `$HOME/.local/bin` |

The payload unpacks to `$CODEX_HOME/packages/standalone/releases/<version>-<target>/` with
a `current` symlink pointing at it. Because the release directory name is
architecture-specific (`x86_64-unknown-linux-musl` on Lambda, `aarch64-apple-darwin` on the
MacBook), never reference a versioned path — always go through `current`.

Setting these variables is fine as long as it is done *consistently*. The failure mode is
setting `CODEX_HOME` for the install only: the payload and state land there, but later
shells without the variable fall back to `$HOME/.codex` and see a different state
directory, so auth and session history silently split across two locations. If you want a
non-default `CODEX_HOME`, export it from `~/.zshrc.local` so every shell agrees.

This repo's `./install.sh` deliberately does not manage any of the above — the Codex
installer creates its own symlink, and `~/.local/bin` is already on PATH via `zshrc`
(see the `~/.local/bin` block), so `codex` works in the next shell with no dotfiles change.
