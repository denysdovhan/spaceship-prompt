#
# Batchsys
#
# Batchsys will add the ID of the current job of a batch engine/job scheduler to
# the prompt output.
# Currently supported: Slurm, LSF, PBS

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_BATCHSYS_SHOW="${SPACESHIP_BATCHSYS_SHOW=true}"
SPACESHIP_BATCHSYS_PREFIX="${SPACESHIP_BATCHSYS_PREFIX=""}"
SPACESHIP_BATCHSYS_SUFFIX="${SPACESHIP_BATCHSYS_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_BATCHSYS_SYMBOL="${SPACESHIP_BATCHSYS_SYMBOL="💼 "}"
SPACESHIP_BATCHSYS_COLOR="${SPACESHIP_BATCHSYS_COLOR="white"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_batchsys() {
	[[ $SPACESHIP_BATCHSYS_SHOW == false ]] && return

	local 'job_id'

	if   [[ -n $SLURM_JOBID ]]; then
		job_id=$SLURM_JOBID
	elif [[ -n $LSB_JOBID ]]; then
		job_id=$LSB_JOBID
	elif [[ -n $PBS_JOBID ]]; then
		job_id=$PBS_JOBID
	fi

	[[ -z $job_id ]] && return

	spaceship::section \
	  "$SPACESHIP_BATCHSYS_COLOR" \
	  "$SPACESHIP_BATCHSYS_PREFIX" \
	  "$SPACESHIP_BATCHSYS_SYMBOL$job_id" \
	  "$SPACESHIP_BATCHSYS_SUFFIX"
}
