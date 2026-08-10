#!/usr/bin/env bash
# Simple Waybar custom module to display live download / upload speeds.
# Reads byte counters from /sys/class/net/<iface>/statistics.

# Detect the primary active (UP, non-loopback) interface.
get_interface() {
  for iface in /sys/class/net/*; do
    name="$(basename "$iface")"
    [[ "$name" == "lo" ]] && continue
    [[ "$(cat "$iface/operstate" 2>/dev/null)" == "up" ]] &&
      [[ -n "$(cat "$iface/statistics/rx_bytes" 2>/dev/null)" ]] && {
      echo "$name"
      return
    }
  done
}

IFACE="$(get_interface)"
[[ -z "$IFACE" ]] && echo "" && exit 0

rs=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes)
ts=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes)
sleep 1
r2=$(cat /sys/class/net/"$IFACE"/statistics/rx_bytes)
t2=$(cat /sys/class/net/"$IFACE"/statistics/tx_bytes)

RD=$(( (r2 - rs) ))
TU=$(( (t2 - ts) ))

# Convert single-byte rate to a human-readable string (pure bash, no bc).
human() {
  local b=$1 n=$1
  if   (( n >= 1073741824 )); then printf "%.1fG" "$(( (n * 10) / 1073741824 / 10 )).$(( (n * 10) / 1073741824 % 10 ))"
  elif (( n >= 1048576    )); then printf "%.1fM" "$(( (n * 10) / 1048576 / 10 )).$(( (n * 10) / 1048576 % 10 ))"
  elif (( n >= 1024       )); then printf "%.1fK" "$(( (n * 10) / 1024 / 10 )).$(( (n * 10) / 1024 % 10 ))"
  else                                 printf "%dB" "$n"
  fi
}

DOWN="$(human "  $RD")"
UP="$(human "  $TU")"

printf "%s  %s\n" "  $DOWN" "  $UP"
printf "%s\n" "Interface: $IFACE"
printf "%s\n" "Download: $DOWN/s"
printf "%s\n" "Upload:   $UP/s"
