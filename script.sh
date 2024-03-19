#!/bin/bash

# Asegúrate de proporcionar el PID correcto del proceso del navegador como argumento
PID=$1

# Verifica que se haya proporcionado un PID
if [ -z "$PID" ]; then
  echo "Uso: $0 <PID del navegador>"
  exit 1
fi

# Directorio donde buscar descriptores de archivo
fd_dir="/proc/$PID/fd"

# Verifica que el directorio exista (es decir, que el PID sea válido)
if [ ! -d "$fd_dir" ]; then
  echo "El PID proporcionado no corresponde a un proceso existente."
  continue
fi


for fd in $fd_dir/*; do
  fd_number=$(basename "$fd")

  # Ignora descriptores de archivo especiales
  if [[ "$fd_number" == "0" || "$fd_number" == "1" || "$fd_number" == "2" ]]; then
    continue
  fi

  # Comprueba si el descriptor de archivo todavía existe antes de intentar leerlo
  if [ ! -e "$fd" ]; then
    continue  # Salta al siguiente descriptor si este ya no existe
  fi

  # Buscar URLs
 timeout 2s  grep -Ea 'http://[a-zA-Z0-9.-]*/' "$fd"  2>/dev/null
done

echo "Búsqueda completada."
exit 0
