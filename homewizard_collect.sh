#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.11-small -p nix gnused dash bc jq curl cacert flock
set -eu

stamp="$(date +%s)"

for x in active_current_l1_a\
         active_current_l2_a\
         active_current_l3_a\
         active_power_l1_w\
         active_power_l2_w\
         active_power_l3_w\
         active_power_w\
         active_voltage_l1_v\
         active_voltage_l2_v\
         active_voltage_l3_v\
         total_power_export_kwh\
         total_power_export_t1_kwh\
         total_power_import_kwh\
         total_power_import_t1_kwh\
         wifi_strength\
    ; do
    dash ./cmd/data.sh "$x" | { read -r d; echo "[$stamp,$d]"; } | dash ./homewizard_convert.sh "$x"
done;
