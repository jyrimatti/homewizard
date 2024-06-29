#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash sqlite
set -eu

dbfile="${1:-./homewizard.db}"

echo "SELECT imported - exported
      FROM (
        SELECT (SELECT (MAX(measurement)-MIN(measurement))
                FROM total_power_export_kwh
                WHERE instant >= strftime('%s', strftime('%Y-%m-%dT%H:%M:00Z', Datetime('now', '-'||(strftime('%M', 'now') % 15)||' minutes')))) exported,
               (SELECT (MAX(measurement)-MIN(measurement))
                FROM total_power_import_kwh
                WHERE instant >= strftime('%s', strftime('%Y-%m-%dT%H:%M:00Z', Datetime('now', '-'||(strftime('%M', 'now') % 15)||' minutes')))) imported)"\
 | sqlite3 "$dbfile"\
 | { read -r val; printf '%.3f\n' "$val"; }
