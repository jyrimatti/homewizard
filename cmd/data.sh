#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash cacert curl jq bkt
set -eu

key="${1:-}"
if [ "$key" = "" ]; then
    key='keys.[]'
else
    key=".$key"
fi

dash ./homewizard_get.sh | jq -r "$key"
