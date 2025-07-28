# Dotfiles (Symlink-based setup)

These are my personal configuration files for Zsh, Vim, Tmux, and Git.  
They are managed with a **cloned git repository and symbolic links** rather than a bare repo.

This branch (`symlinks-aurora`) is configured specifically to reproduce an issue with Zsh on Aurora.

---

## How I set this up

1. Clone the repository:

```bash
git clone https://github.com/adpartin/dotfiles.git ~/dotfiles
```

2. Create symbolic links

```
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
```

3. Install Antidote (plugin manager):
```bash
mkdir -p ~/.zsh
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.zsh/antidote
```

4. Start a login shell:
```bash
exec /usr/bin/zsh -l
```
