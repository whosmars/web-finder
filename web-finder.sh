#!/bin/bash

# Comprueba si se proporcionó un archivo de wordlist como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <wordlist.txt>"
    exit 1
fi

wordlist=$1
output_pids="pids_list.txt"

# Asegúrate de que el archivo de salida esté vacío al inicio
> "$output_pids"

# Lee cada línea de la wordlist y busca procesos correspondientes
while IFS= read -r line; do
    pids=$(top -b -n 1 | grep "$line" | awk '{print $1}')
    for pid in $pids; do
        echo $pid >> "$output_pids"
    done
done < "$wordlist"

echo "PIDs guardados en $output_pids"

# Lee cada PID del archivo de salida y ejecuta script.sh para cada uno
while IFS= read -r pid; do
    echo "Procesando PID: $pid"
    ./script.sh "$pid"
done < "$output_pids"


