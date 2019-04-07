#!/usr/bin/env bats
load test_helper

SCRIPT_LOCATION="scripts/full_uninstaller.sh"

@test "force-new" {
  run "./scripts/full_uninstaller.sh"
  echo $status >&3
  echo $output >&3
  echo $lines >&3

}
# @test "eosio folder found" {
#   run "scripts/full_uninstaller.sh"
#   echo $status >&3
#   echo $output >&3
# }

