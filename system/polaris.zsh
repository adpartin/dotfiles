# System config for Polaris (ALCF HPE/Cray)
# Sourced by zshrc when hostname matches *polaris*

# ---------------------------------------------------------------------------
# Login vs. compute node detection
# On Polaris (PBS), $PBS_ENVIRONMENT is set on compute nodes
# (value is PBS_BATCH or PBS_INTERACTIVE). Unset on login nodes.
# We use this to avoid loading GPU-heavy modules on login nodes,
# which adds latency without benefit.
# ---------------------------------------------------------------------------
if [[ -n "$PBS_ENVIRONMENT" ]]; then
    _polaris_node_type="compute"
else
    _polaris_node_type="login"
fi

# ---------------------------------------------------------------------------
# Modules
# Default modules are already loaded by the system at login:
#   PrgEnv-nvidia/8.6.0, nvidia/25.5, cray-mpich/9.0.1, craype/2.7.35, etc.
# No need to repeat them here.
#
# cuda/12.9 is NOT in the default env — load it on compute nodes for
# GPU jobs that need nvcc or CUDA headers (e.g., building torch extensions).
# ---------------------------------------------------------------------------
if [[ "$_polaris_node_type" == "compute" ]]; then
    module load cuda/12.9 2>/dev/null
fi

# ---------------------------------------------------------------------------
# ALCF proxy
# Required for internet access from both login and compute nodes
# (pip install, git clone, wget, curl, etc.)
# ---------------------------------------------------------------------------
export http_proxy="http://proxy.alcf.anl.gov:3128"
export https_proxy="http://proxy.alcf.anl.gov:3128"
export ftp_proxy="http://proxy.alcf.anl.gov:3128"
export no_proxy="localhost,127.0.0.1,.alcf.anl.gov"

# ---------------------------------------------------------------------------
# Conda (ALCF system-managed miniconda3)
# The generic conda lazy-loader in zshrc searches user-space paths
# ($HOME/miniconda3, etc.) which don't exist on Polaris.
# Override it here to point to ALCF's shared install instead.
# This avoids duplicating a large conda installation in $HOME on Lustre.
#
# Path as of 2025-09 (old /soft/datascience path was retired):
#   /soft/applications/conda/2025-09-25/mconda3
# ---------------------------------------------------------------------------
conda() {
    unfunction conda          # remove this stub; real conda takes over after init
    _conda_init_done=1        # tell zshrc the lazy-load is done
    local _conda_sh="/soft/applications/conda/2025-09-25/mconda3/etc/profile.d/conda.sh"
    if [[ -f "$_conda_sh" ]]; then
        source "$_conda_sh"   # defines the real conda function
    else
        echo "[polaris] Error: ALCF conda not found at $_conda_sh"
        return 1
    fi
    conda "$@"                # forward the original command (e.g., conda activate myenv)
}

# ---------------------------------------------------------------------------
# Project directories
# Active PBS allocations (from sbank):
#   IMPROVE_Aim1  /lus/eagle  97k node-hours  expires 2026-04-01
#   bvbrc         /lus/eagle   1k node-hours  expires 2026-05-01
# ---------------------------------------------------------------------------
export IMPROVE_DIR="/lus/eagle/projects/IMPROVE_Aim1"
export BVBRC_DIR="/lus/eagle/projects/bvbrc"

alias cdimprove="cd $IMPROVE_DIR"
alias cdbvbrc="cd $BVBRC_DIR"

# Other project storage (no active allocation but data exists):
export GRAND_DIR="/lus/grand/projects/CSC249ADOA01"
export CVD_DIR="/lus/eagle/projects/CVD-Mol-AI"

# ---------------------------------------------------------------------------
# Clean up
# ---------------------------------------------------------------------------
unset _polaris_node_type
