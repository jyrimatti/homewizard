#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash cacert curl bkt flock
set -eu

. ./homewizard_env.sh

lock="${BKT_CACHE_DIR:-/tmp}/homewizard.lock"

flock "$lock" \
    bkt --discard-failures --ttl 6s --stale 5s -- \
        curl --no-progress-meter -L "http://$HOMEWIZARD_HOST/api/v1/data"
