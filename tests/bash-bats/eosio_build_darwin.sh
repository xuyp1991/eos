#!/usr/bin/env bats
load test_helper

SCRIPT_LOCATION="scripts/eosio_build_darwin.sh"
TEST_LABEL="[eosio_build_darwin]"

# A helper function is available to show output and status: `debug`

@test "${TEST_LABEL} > Usage is visible with right interaction" {
  run ./$SCRIPT_LOCATION
  [[ $output =~ "Usage ---" ]] || exit
  
}
