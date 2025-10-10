#!/bin/bash
TRAIN_DIR="splited_data"
CHAR_DIR="char_data"

mkdir -p "$CHAR_DIR"

for file in "$TRAIN_DIR"/{train,test}.*; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    basename_file=$(basename "$file")
    output_file="${CHAR_DIR}/${basename_file}"
    
    echo "Conversion de $file en caractères..."
    
    # Séparer chaque caractère par un espace
    sed 's/./& /g' "$file" > "$output_file"
done

echo "Conversion terminée !"