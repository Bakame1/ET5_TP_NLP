#!/bin/bash
# prepare_char_data_with_space_token.sh
TRAIN_DIR="splited_data"
CHAR_DIR="char_data_space_token"

mkdir -p "$CHAR_DIR"

for file in "$TRAIN_DIR"/{train,test}.*; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    basename_file=$(basename "$file")
    output_file="${CHAR_DIR}/${basename_file}"
    
    echo "Conversion de $file avec <SPACE>..."
    
    # Remplacer les espaces par <SPACE>, puis séparer chaque caractère
    sed 's/ /<SPACE>/g' "$file" | sed 's/./& /g' > "$output_file"
done

echo "Conversion avec <SPACE> terminée !"