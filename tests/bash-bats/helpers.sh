#!/usr/bin/env bats
load test_helper

# A helper function is available to show output and status: `debug`

# Load helpers (BE CAREFUL)
. ./scripts/helpers.bash

TEST_NAME="[helpers]"

@test "${TEST_NAME} > execute" {
  ## DRYRUN WORKS (true, false, and empty)
  run execute exit 1
  ( [[ $output =~ "Executing: exit 1" ]] && [[ $status -eq 0 ]] ) || exit
  DRYRUN=false
  run execute exit 1
  ( [[ $output =~ "Executing: exit 1" ]] && [[ $status -eq 1 ]] ) || exit
  DRYRUN=
  run execute exit 1
  ( [[ $output =~ "Executing: exit 1" ]] && [[ $status -eq 1 ]] ) || exit
}
