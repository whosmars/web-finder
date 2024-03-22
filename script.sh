#!/bin/bash

# Make sure to provide the correct PID of the browser process as an argument
PID=$1


# Check if the PID have been provided
if [ -z "$PID" ]; then
  echo "Uso: $0 <PID del navegador>"
  exit 1
fi

# Relative path to the file descriptor directory
fd_dir="/proc/$PID/fd"

# Check if the directory exists (i.e., the PID is valid)
if [ ! -d "$fd_dir" ]; then
  echo "El PID proporcionado no corresponde a un proceso existente."
  continue
fi


for fd in $fd_dir/*; do
  fd_number=$(basename "$fd")
  # 0: stdin, 1: stdout, 2: stderr
  # Ignore special file descriptors
  if [[ "$fd_number" == "0" || "$fd_number" == "1" || "$fd_number" == "2" ]]; then
    continue
  fi

  # Check if the file descriptor still exists before trying to read it
  if [ ! -e "$fd" ]; then
    continue  # Continue to the next file descriptor if it no longer exists
  fi

  # Find URLs in the file descriptor using grep
 timeout 2s  grep -Ea 'http://[a-zA-Z0-9.-]*/' "$fd"  2>/dev/null
done

echo "Búsqueda completada."
exit 0
