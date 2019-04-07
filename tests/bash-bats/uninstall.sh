#!/usr/bin/env bats
load test_helper

SCRIPT_LOCATION="scripts/eosio_uninstall.sh"

# To find the exit status of the executed script or command, use `echo "STATUS: ${status}" >&3`
# To see all of the output from the script, use `printf " ---------\\n ${output}\\n ---------\\n\\n" >&3`
# To see a specific line in the output, use `echo $lines[0] >&3`
# A helper function is available to do this: `debug`

@test "[-]?help/help/* will show usage" {
  run ./$SCRIPT_LOCATION -help
  [[ $output =~ "Usage ---" ]] || exit
  run ./$SCRIPT_LOCATION --help
  [[ $output =~ "Usage ---" ]] || exit
  run ./$SCRIPT_LOCATION help
  [[ $output =~ "Usage ---" ]] || exit
  run ./$SCRIPT_LOCATION blah
  [[ $output =~ "Usage ---" ]] || exit
}

@test "--force" {
  run ./$SCRIPT_LOCATION --force
  [[ "${output##*$'\n'}" == "[EOSIO Removal Complete]" ]] || exit
}

@test "--force + --full" {
  run ./$SCRIPT_LOCATION --force --full
  debug
  ([[ ! "${output[*]}" =~ "Library/Application\ Support/eosio" ]] && [[ ! "${output[*]}" =~ ".local/share/eosio" ]]) && exit
  [[ "${output##*$'\n'}" == "[EOSIO Removal Complete]" ]] || exit
}

