export COLOR_NC=$(tput sgr0) # No Color
export COLOR_RED=$(tput setaf 1)
export COLOR_GREEN=$(tput setaf 2)
export COLOR_YELLOW=$(tput setaf 3)
export COLOR_BLUE=$(tput setaf 4)
export COLOR_MAGENTA=$(tput setaf 5)
export COLOR_CYAN=$(tput setaf 6)
export COLOR_WHITE=$(tput setaf 7)

function execute() {
  ( [[ ! -z "${VERBOSE}" ]] && $VERBOSE ) && echo "- Executing: $@"
  ( [[ ! -z "${DRYRUN}" ]] && $DRYRUN ) || "$@"
}

