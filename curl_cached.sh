#! /usr/bin/env nix-shell
#! nix-shell --pure --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash cacert curl flock
set -eu

url="$1"
minutes="${2:-1}"

outputfile="${XDG_RUNTIME_DIR:-/tmp}/$(basename "$PWD")/$(echo -n "$url" | tr -c '[:alnum:]' '_')"

test -e "$(dirname "$outputfile")" || mkdir -p "$(dirname "$outputfile")"

(
    flock 8

    fetch() {
        curl -4 --no-progress-meter -L "$url" -o "$outputfile"
    }

    if [ ! -f "$outputfile" ] || [ ! -s "$outputfile" ]; then
        fetch
    else
        for i in $(find "$outputfile" -mmin +$minutes); do
            fetch
        done
    fi

    cat "$outputfile"
) 8> "$outputfile.lock"