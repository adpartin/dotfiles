# Aliases — sourced by zshrc
#
# These are general-purpose aliases that work on all systems.
# System-specific aliases (directory shortcuts, module loads)
# go in system/*.zsh instead.

# ----------------------------------------------------------
# Git
# ----------------------------------------------------------
alias gst="git status"                  # replaces the OMZ git plugin's gst
alias gl="git log --oneline --graph"    # compact git log with branch graph

# ----------------------------------------------------------
# Python / Conda
# ----------------------------------------------------------
alias coac="conda activate"     # shorter than typing the full command
alias codea="conda deactivate"  # note: these trigger conda lazy-loading on first use

# ----------------------------------------------------------
# Shell
# ----------------------------------------------------------
alias sz="source ~/.zshrc"      # quickly reload zshrc after making changes

# ----------------------------------------------------------
# Vim
# ----------------------------------------------------------
alias vw="vim -c ':VimwikiIndex'"   # open Vim directly into VimWiki
