#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep CURL_CACHED_MINUTES -i dash -I channel:nixos-23.11-small -p nix dash cacert curl gnused flock jq
set -eu

key="${1:-}"
if [ "$key" = "" ]; then
    key='keys.[]'
else
    key=".$key"
fi

. ./homewizard_env.sh

dash ./curl_cached.sh "http://$HOMEWIZARD_HOST/api/v1/data" | jq -r "$key"
