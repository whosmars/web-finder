#!/bin/bash

# Check if the wordlist file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <wordlist.txt>"
    exit 1
fi

wordlist=$1
output_pids="pids_list.txt"

# This check if the file exists and if it is empty
> "$output_pids"


# For each line in the wordlist, the script will execute the top command and then the grep command, so the real time complexity of the script is O(n)
while IFS= read -r line; do
    pids=$(top -b -n 1 | grep "$line" | awk '{print $1}')
    for pid in $pids; do
        echo $pid >> "$output_pids"
    done
done < "$wordlist"

echo "PIDs guardados en $output_pids"

#Read the PID from the output file and execute script.sh for each one, then the real time complex of the script is O(n*n)
while IFS= read -r pid; do
    echo "Procesando PID: $pid"
    ./script.sh "$pid"
done < "$output_pids"


