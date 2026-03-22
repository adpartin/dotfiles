# System config for Lambda GPU nodes (lambda0, etc.)
# This file is sourced automatically when hostname contains "lambda".
# See the "System detection" section in zsh/zshrc.

# ----------------------------------------------------------
# ssh-agent
# Lambda doesn't start an agent automatically (unlike ALCF Polaris).
# Start one if not already running, so ssh-add only prompts once
# per session and git/ssh work without repeated passphrase prompts.
# ----------------------------------------------------------
if [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" >/dev/null
fi

# ----------------------------------------------------------
# Navigation — quick cd to common project directories
# ----------------------------------------------------------
alias prj="cd /lambda_stor/data/apartin/projects"
alias vl="cd /vol/ml/apartin/projects"
