function execute() {
  ( [[ ! -z "${VERBOSE}" ]] && $VERBOSE ) && echo "- Executing: $@"
  ( [[ ! -z "${DRYRUN}" ]] && $DRYRUN ) || "$@"
}