function execute() {
  echo " - Executing: $@"
  $DRYRUN || "$@"
}