#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash sqlite coreutils gnused curl cacert flock bc jq
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./homewizard_collect.sh | sqlite3 -cmd ".timeout 90000" ./homewizard.db
