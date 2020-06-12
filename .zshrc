# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/ccs/home/apartin/.oh-my-zsh"

# ---------------------
# Figure out the system
# ---------------------
hn=`hostname -f`
sys_name=`uname -a`

if [[ "${hn}" == *"olcf.ornl"* ]]
then
    echo "You are on ${hn}"
    export ZSH="/ccs/home/apartin/.oh-my-zsh"
elif [[ "${sys_name}" == *"Darwin"* ]]
then
    echo "You are on ${sys_name}"
    export ZSH="/Users/apartin/.oh-my-zsh"
else
    echo "You are on ${hn}"
    export ZSH="/homes/apartin/.oh-my-zsh"
fi

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

# ---------------------
# Alises Summit
# ---------------------
alias lvim="module load vim"
alias uvim="module unload vim"
# alias ltmux="module load tmux"
alias ltmux="module load tmux/3.1b"
alias utmux="module unload tmux"
alias lenv="module load ibm-wml-ce/1.7.0-2"
alias uenv="module unload ibm-wml-ce/1.7.0-2"
# ---------------------

# stackoverflow.com/questions/229551
hn=`hostname -f`
if [[ "${hn}" == *"olcf.ornl"* ]];
then
    # echo 1
    alias prj="cd /ccs/proj/med106/apartin"
elif [[ "${hn}" == *"lambda"* ]];
    # echo 2
    alias prj="cd /lambda_stor/data/apartin/projects"
then
else
    # echo 3
    # TODO this doesn't work??
    alias prj="cd /vol/ml/apartin/projects/"
fi

# ---------------------
# General
# ---------------------
alias coac="conda activate"
alias codea="conda deactivate"

# www.linuxtechi.com/rsync-command-examples-linux/
alias rsc="rsync -zarvh --progress" 

alias sz="source ~/.zshrc"
# ---------------------
# ========================================================================

# ---------------------
# Setting Conda
# ---------------------
# # github.com/conda/conda/issues/6826#issuecomment-397287212
# # stackoverflow.com/questions/57660263/tmux-recognised-conda-env-but-still-use-the-default-python
# source /sw/summit/ibm-wml-ce/anaconda-base/etc/profile.d/conda.sh
# [[ -z $TMUX ]] || conda deactivate; conda activate base

hn=`hostname -f`
sys_name=`uname -a`

if [[ "${hn}" == *"olcf.ornl"* ]]
then
    # echo "You are on ${hn}"
    source /sw/summit/ibm-wml-ce/anaconda-base/etc/profile.d/conda.sh
    [[ -z $TMUX ]] || conda deactivate; conda activate base

elif [[ "${sys_name}" == *"Darwin"* ]]
then
    # # echo "You are on ${sys_name}"
    # # >>> conda initialize >>>
    # # !! Contents within this block are managed by 'conda init' !!
    # __conda_setup="$('/Users/apartin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    # if [ $? -eq 0 ]; then
    #     eval "$__conda_setup"
    # else
    #     if [ -f "/Users/apartin/miniconda3/etc/profile.d/conda.sh" ]; then
    #         . "/Users/apartin/miniconda3/etc/profile.d/conda.sh"
    #     else
    #         export PATH="/Users/apartin/miniconda3/bin:$PATH"
    #     fi
    # fi
    # unset __conda_setup
    # # <<< conda initialize <<<

    source /Users/apartin/miniconda3/etc/profile.d/conda.sh
    [[ -z $TMUX ]] || conda deactivate; conda activate base

else
    # echo "You are on ${hn}"
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
fi


