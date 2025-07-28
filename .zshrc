# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
emulate -R zsh  # ensure native zsh mode

# ---------------------
# Determine system
# ---------------------
HOSTNAME=`hostname -f`
SYSTEM_NAME=`uname -a`

if [[ "${HOSTNAME}" == *"olcf.ornl"* ]]
then
    # echo "You are on ${HOSTNAME}"
    # export ZSH="/ccs/home/apartin/.oh-my-zsh"
    export MY_HOSTNAME_CONTEXT="OLCT"
elif [[ "${SYSTEM_NAME}" == *"Darwin"* ]]
then
    # echo "You are on ${SYSTEM_NAME}"
    # export ZSH="/Users/apartin/.oh-my-zsh"
    export MY_HOSTNAME_CONTEXT="MAC"
else
    # echo "You are on ${HOSTNAME}"
    # export ZSH="/homes/apartin/.oh-my-zsh"
    export MY_HOSTNAME_CONTEXT="GENERIC"
fi

# ---------------------
# Fix for wrapped shell
# ---------------------
if [ -z "$ZSH_VERSION" ]; then
  export ZSH_VERSION=$(zsh --version | awk '{print $2}')
fi

# ---------------------
# Antidote setup
# ---------------------
if [ -n "$ZSH_VERSION" ]; then
  ANTIDOTE_DIR="${HOME}/.zsh/antidote"
  fpath+=("${ANTIDOTE_DIR}")
  if [ -r "${ANTIDOTE_DIR}/antidote.zsh" ]; then
    source "${ANTIDOTE_DIR}/antidote.zsh"
    source <("${ANTIDOTE_DIR}/antidote.zsh" load < "${HOME}/.zsh_plugins.txt")
  fi
fi


# Terminal
export TERM=xterm-256color

# Editor
export EDITOR="vim"
export VISUAL="vim"


# ---------------------
# Vim mode
# ---------------------
# gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# github.com/BrodieRobertson/dotfiles/blob/master/.zshrc
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
if bindkey -M menuselect > /dev/null 2>&1; then
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    bindkey -v '^?' backward-delete-char
fi


# ------------------------------------------
# Aliases
# ------------------------------------------
alias prj="cd /lambda_stor/data/apartin/projects"  # Lambda
alias vl="cd /vol/ml/apartin/projects"  # Vol
alias coac="conda activate"
alias codea="conda deactivate"
alias sz="source ~/.zshrc"
alias vw="vim -c ':VimwikiIndex'"


# ------------------------------------------
# Setting Conda
# ------------------------------------------
# # github.com/conda/conda/issues/6826#issuecomment-397287212
# # stackoverflow.com/questions/57660263/tmux-recognised-conda-env-but-still-use-the-default-python
# source /sw/summit/ibm-wml-ce/anaconda-base/etc/profile.d/conda.sh
# [[ -z $TMUX ]] || conda deactivate; conda activate base

HOSTNAME=`hostname -f`
SYSTEM_NAME=`uname -a`

if [[ "${HOSTNAME}" == *"olcf.ornl"* ]]
then
    # echo "You are on ${HOSTNAME}"
    # source /sw/summit/ibm-wml-ce/anaconda-base/etc/profile.d/conda.sh  # commented out by conda initialize
    [[ -z $TMUX ]] || conda deactivate; conda activate base

elif [[ "${SYSTEM_NAME}" == *"Darwin"* ]]
then
    # source /Users/apartin/miniconda3/etc/profile.d/conda.sh  # commented out by conda initialize
    [[ -z $TMUX ]] || conda deactivate; conda activate base

else
    # echo "You are on ${HOSTNAME}"
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    
    __conda_setup="$('/homes/apartin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/homes/apartin/miniconda3/etc/profile.d/conda.sh" ]; then
            # . "/homes/apartin/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
            # export PATH="/homes/apartin/miniconda3/bin:$PATH"  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# Prevent duplicates of PATH variables
typeset -U PATH
