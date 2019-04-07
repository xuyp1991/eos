#!/usr/bin/env bash
set -eo pipefail

usage() {
   printf "Usage --- \\n $ %s [ --full ] [ --force ]\\n
     --full: Removal of data directory (be absolutely sure you want to delete it before using this!)\\n
     --force: Unattended uninstall which works regardless of the eosio directory existence.\\n              This helps cleanup dependencies and start fresh if you need to.
   \\n" "$0"
}

# User input handling
PROCEED=false
DEP_PROCEED=false
FORCED=false
FULL=false
if [[ $@ =~ [[:space:]]?--force[[:space:]]? ]]; then
   echo "[Forcing Unattended Removal]"
   FORCED=true
   DEP_PROCEED=true
fi
if [[ $@ =~ [[:space:]]?--full[[:space:]]? ]]; then
   echo "[Removing eosio data (nodeos generated state, etc)]"
   while true; do
      if $FORCED; then
         FULL=true
      else
         read -p "Removal of the eosio data directory will require a resync of data which can take days. Do you wish to proceed? (y/n) " PROCEED
         case $PROCEED in
            "" ) echo "What would you like to do?";;
            0 | [Yy]* )
               FULL=true
            break;;
            1 | [Nn]* ) break;;
            * ) echo "Please type 'y' for yes or 'n' for no.";;
         esac
      fi
   done
fi
if [[ $@ =~ [--]?help ]] || ([[ ! -z $@ ]] && [[ ! $@ =~ [[:space:]]?--force[[:space:]]? ]] && [[ ! $@ =~ [[:space:]]?--full[[:space:]]? ]]); then usage && exit; fi

if [[ -d "/usr/local/include/eosio" ]]; then
   EOSIO_LOCATION="/usr/local/include/eosio"
elif [[ -d "$HOME/opt/eosio" ]]; then
   EOSIO_LOCATION="$HOME/opt/eosio"
fi

# Removal
[[ ! -z "${EOSIO_LOCATION}" ]] && printf "[EOSIO Installation Found: ${EOSIO_LOCATION}]\n"
while true; do
   [[ $FORCED == false ]] && read -p "Do you wish to remove the installation? (y/n) " PROCEED
   case $PROCEED in
      "" ) echo "What would you like to do?";;
      0 | true | [Yy]* )
         echo " - Removing EOSIO and Dependencies..."
         if [[ $( uname ) == "Darwin" ]]; then
            for package in $(cat scripts/eosio_build_darwin_deps | cut -d, -f4 2>/dev/null); do
               while true; do
                  $DEP_PROCEED && read -p "Do you wish to uninstall and unlink all brew installed llvm@4 versions? (y/n) " DEP_PROCEED
                  case $DEP_PROCEED in
                     "") "What would you like to do?";;
                     0 | true | [Yy]* )
                        brew uninstall $package --force
                        brew cleanup -s $package
                        echo " - Uninstalled dependency ${package}!"
                        break;;
                     1 | false | [Nn]* ) break;;
                     * ) echo "Please type 'y' for yes or 'n' for no.";;
                  esac
               done
            done
         fi
         # Handle cleanup of data directory
         if $FULL; then
            if [[ -d ~/Library/Application\ Support/eosio ]]; then rm -rf ~/Library/Application\ Support/eosio; fi # Mac OS
            if [[ -d ~/.local/share/eosio ]]; then rm -rf ~/.local/share/eosio; fi # Linux
         fi
         rm -rf $EOSIO_LOCATION
         rm -f $HOME/bin/eosio-launcher
         rm -rf $HOME/lib/cmake/eosios
         rm -rf $HOME/opt/llvm
         rm -f $HOME/opt/boost
         rm -rf $HOME/src/boost_*
         rm -rf $HOME/src/cmake-*
         rm -rf $HOME/share/cmake-*
         rm -rf $HOME/share/aclocal/cmake*
         rm -rf $HOME/doc/cmake*
         rm -f $HOME/bin/nodeos $HOME/bin/keosd $HOME/bin/cleos $HOME/bin/ctest $HOME/bin/*cmake* $HOME/bin/cpack
         rm -rf $HOME/src/mongo*
         echo " - EOSIO Removal Complete!"
         break;;
      1 | false | [Nn]* )
         echo " - Cancelled EOSIO Removal!"
         break;;
      * ) echo "Please type 'y' for yes or 'n' for no.";;
   esac
done

