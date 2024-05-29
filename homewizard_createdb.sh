#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p dash sqlite
set -eu

sqlite3 homewizard.db < homewizard_create.sql