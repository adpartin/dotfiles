References:
- https://www.atlassian.com/git/tutorials/dotfiles

# Initial setup of the (bare) git repo for dotfiles
Create bare git repo and an alias to interact with the repo.
```
$ git init --bare $HOME/.dotfiles
$ alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dconfig config --local status.showUntrackedFiles no
```

Add the alias to your shell config file (.zshrc).
```
$ echo "alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
$ source ~/.zshrc
```

Add and commit dotfiles to the local repo.
```
$ dconfig add .gitconfig .tmux.conf .vimrc .zshrc 
$ dconfig commit -m “Initial commit"
```

Create a GitHub repo and push (note that we use the alias `dconfig` instead of `git`).
```
$ dconfig remote add origin git@github.com:adpartin/dotfiles.git
$ dconfig remote -v
$ dconfig push -u origin master
```

# Installing dotfiles on a new system
Backup the dotfiles you want to replace.
```sh
TODO
```

Install shell tools (https://ohmyz.sh/)
```sh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$ ~/.fzf/install
```

- If Vundle (https://github.com/VundleVim/Vundle.vim), download from here:
    ```sh
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```
    Open `.vimrc`, install plugins by running `:PluginInstall` and source `.vimrc` with `:so %`.

- If Vim-plug (https://github.com/junegunn/vim-plug), download from here:
    ```sh
    $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
    Open `.vimrc`, install plugins by running `:PlugInstall` and source `.vimrc` with `:so %`.


Create alias to manage the repo.
```
$ alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Add repo name to .gitignore.
```
$ echo ".dotfiles" >> .gitignore
```

Clone the repo.
```
$ git clone --bare git@github.com:adpartin/dotfiles.git $HOME/.dotfiles
```

Checkout the actual files from the repo.<br>
Note that `dconfig checkout` will show an error if `$HOME` contains config files (dotfiles) that the repo is designed to track. In this case, backup those files somewhere and re-run the commands.
```
$ dconfig checkout
$ dconfig config --local status.showUntrackedFiles no
```
