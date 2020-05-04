# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="/homes/apartin/.oh-my-zsh"

# Theme
# github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gianu"

# --------------------------------------------
# Plugins
# --------------------------------------------
# github.com/ohmyzsh/ohmyzsh/wiki/Plugins
# The plugins provides aliases and functions.
# Too many plugins slow down shell startup!
# Standard plugins are in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)
# --------------------------------------------

source $ZSH/oh-my-zsh.sh

# ========================================================================
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Editor
export EDITOR="vim"
export VISUAL="vim"

# Dotfiles
alias dconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Aliases
# TODO
# rsync
# dropbox
# cd /vol/ml/aprtin/projects
# CUDA_VISIBLE_DEVICES

# ========================================================================


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/homes/apartin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/homes/apartin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/homes/apartin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/homes/apartin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

