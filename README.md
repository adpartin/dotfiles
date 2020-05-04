References:
- https://www.atlassian.com/git/tutorials/dotfiles

### Initial setup of the (bare) git repo for dotfiles
Create bare git repo and alias to interact with the repo:
```
$ git init --bare $HOME/.dotfiles
$ alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dconfig config --local status.showUntrackedFiles no
```

Add alias to your shell config file (.zshrc):
```
$ echo "alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
$ source ~/.zshrc
```

Add and commit dotfiles to repo:
```
$ dconfig add .gitconfig .tmux.conf .vimrc .zshrc 
$ dconfig commit -m “Initial commit"
```

Create a GitHub repo and push (note that we use the alias `dconfig` instead of `git`):
```
$ dconfig remote add origin git@github.com:adpartin/dotfiles.git
$ dconfig remote -v
$ dconfig push -u origin master
```

### Installing dotfiles on a new system
Create alias to manage the repo:
```
$ alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Add repo name to .gitignore
```
$ echo ".dotfiles" >> .gitignore
```

Clone the repo
```
$ git clone --bare git@github.com:adpartin/dotfiles.git $HOME/.dotfiles
```

Checkout the actual files from the repo
```
$ dconfig checkout
$ dconfig config --local status.showUntrackedFiles no
```
`dconfig checkout` will show an error if `$HOME` contains config files (dotfiles) that the repo is designed to track. In this case, remove those files and re-run the commands.
