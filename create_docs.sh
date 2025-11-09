#!/bin/bash
# Script to create folders named doc_{i} with nested subfolders and a file containing "Hello World"

# Usage:
#   ./create_docs.sh [num_folders] [depth]
# Example:
#   ./create_docs.sh 100 3
# → Creates 100 folders, each with 3 nested levels.

# Defaults
NUM_FOLDERS=${1:-10}
DEPTH=${2:-1}

# Confirm if large number
if (( NUM_FOLDERS > 10000 )); then
    read -p "You are about to create $NUM_FOLDERS folders. Continue? (y/n): " CONFIRM
    [[ $CONFIRM != [Yy]* ]] && echo "Aborted." && exit 1
fi

echo "Creating $NUM_FOLDERS folder(s) with depth $DEPTH..."

for ((i=1; i<=NUM_FOLDERS; i++)); do
    base="doc_${i}"
    path="$base"
    mkdir -p "$path"
    echo "Hello World" > "$path/file.txt"

    # Create nested directories
    for ((d=1; d<DEPTH; d++)); do
        path+="/subdir_${d}"
        mkdir -p "$path"
        echo "Hello World" > "$path/file.txt"
    done

    # Print progress occasionally
    if (( i % 1000 == 0 )); then
        echo "Created $i folders so far..."
    fi
done

echo "Done! Created $NUM_FOLDERS top-level folders with depth $DEPTH."
