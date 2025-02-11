#! /usr/bin/env nix-shell
#! nix-shell --pure
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash sqlite
set -eu

dbfile="${1:-./homewizard.db}"

echo "SELECT imported - exported
      FROM (
        SELECT (SELECT COALESCE(MAX(measurement)-MIN(measurement), 0)
                FROM total_power_export_kwh
                WHERE instant >= strftime('%s', strftime('%Y-%m-%dT%H:00:00Z', 'now'))) exported,
               (SELECT COALESCE(MAX(measurement)-MIN(measurement), 0)
                FROM total_power_import_kwh
                WHERE instant >= strftime('%s', strftime('%Y-%m-%dT%H:00:00Z', 'now'))) imported)"\
 | sqlite3 "$dbfile"\
 | { read -r val; printf '%.3f\n' "$val"; }

