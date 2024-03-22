## Description

`web-finder.sh` is a shell script that uses a wordlist to search and process the PIDs of processes on a Unix/Linux system. It is particularly intended for identifying web browser processes, but can be used with any type of process listed in the wordlist.

## How to Use

1. **Preparing the Wordlist:**
   - You must have a wordlist (`wordlist.txt`), which contains the names of the processes to search for.
   - You can modify `wordlist.txt` by adding the names of the processes you want to track.

2. **Giving permissions**
   - Ensure `web-finder.sh` has execute permissions:
     ```bash
     chmod +x web finder.sh

3. **Executing `web-finder.sh`:**
   To run the script, use the following command in the terminal:
   ```bash
   ./web-finder.sh wordlist.txt

