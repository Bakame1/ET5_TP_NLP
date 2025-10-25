#!/bin/bash
# Tester le modèle fastText langue par langue

MODEL_DIR="fasttext_models"
TEST_DIR="splited_data"
DATA_DIR="fasttext_data"

MODEL_FILE="${MODEL_DIR}/lang_id.bin"

mkdir -p "${DATA_DIR}/temp"

echo "Test du modèle fastText par langue"
echo "==================================="
echo ""

for test_file in "$TEST_DIR"/test.*; do
    if [ ! -f "$test_file" ]; then
        continue
    fi
    
    # Extraire le code de langue
    lang=$(basename "$test_file" | cut -d. -f2)
    
    # Créer un fichier temporaire avec labels
    temp_file="${DATA_DIR}/temp/test_${lang}.txt"
    sed "s/^/__label__${lang} /" "$test_file" > "$temp_file"
    
    echo "Langue: $lang"
    echo "-------------"
    fasttext test "$MODEL_FILE" "$temp_file"
    echo ""
done

echo "✅ Tests terminés !"