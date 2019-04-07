# You can add `load test_helper` to the .bats files you create to include anything in this file.

# Ensure we're in the root directory to execute
if [[ ! -d "tests" ]] && [[ ! -f "README.md" ]]; then
  echo "You must navigate into the root directory to execute tests..." >&3
  exit 1
fi

make_home_dir() {
  export HOME="$BATS_TMPDIR/bats-eosio"
  mkdir -p $HOME
  echo "[Created \$HOME: ${HOME}]" >&3
}

setup() { # setup is run once before each test
  make_home_dir
  make_eosio_dir
}

teardown() { # teardown is run once after each test, even if it fails


  [[ -n "$HOME" ]] && rm -rf "$HOME"
  echo "[Deleted \$EOSIO_TEST_TMPDIR: ${HOME}]" >&3
}

make_eosio_dir () {
  [[ $1 == "legacy" ]] && EOSIO_DIR=/usr/local/include/eosio || EOSIO_DIR=$HOME/opt/eosio
  mkdir -p $EOSIO_DIR
  echo "[Created \$EOSIO_DIR: ${EOSIO_DIR}]" >&3
}