#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep CURL_CACHED_MINUTES -i dash -I channel:nixos-23.11-small -p dash cacert curl flock
set -eu

url="$1"

minutes="${CURL_CACHED_MINUTES:-0.1}"

outputfile="${XDG_RUNTIME_DIR:-/tmp}/$(basename "$PWD")/$(echo -n "$url" | tr -c '[:alnum:]' '_')"

if [ -f "$outputfile" ] && [ -s "$outputfile" ]; then
    for i in $(find "$outputfile" -mmin -$minutes); do
        cat "$outputfile"
        exit 0
    done
fi

cmd="curl --no-progress-meter -L -o '$outputfile'"
for x in "$@"; do cmd="$cmd '$x'"; done

dir="$(dirname "$outputfile")"
test -e "$dir" || mkdir -p "$dir"

(
    flock 8

    fetch() {
        dash -c "$cmd"
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