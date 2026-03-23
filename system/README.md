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
