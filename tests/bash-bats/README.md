# BATS Bash Testing

For each bash script we have, there should be a separate .sh file within ROOT/tests/bash-bats/.

**You must have bats installed: ([Source Install Instructions](https://github.com/bats-core/bats-core#installing-bats-from-source))** || `brew install bats-core`

 - Running all tests: 
    ```
    $ bats -r tests/bash-bats/*
     ✓ [helpers] > execute
     ✓ [uninstall] > Usage is visible with right interaction
     ✓ [uninstall] > Testing user prompts
     ✓ [uninstall] > --force
     ✓ [uninstall] > --force + --full

    5 tests, 0 failures
    ```