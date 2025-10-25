#!/bin/bash
TRAIN_DIR="char_data_space_token"
MODEL_DIR="char_trigram_models_space"

mkdir -p "$MODEL_DIR"

for train_file in "$TRAIN_DIR"/train.*; do
    if [ ! -f "$train_file" ]; then
        continue
    fi
    
    lang=$(basename "$train_file" | cut -d. -f2)
    vocab_file="${MODEL_DIR}/${lang}.voc"
    bo_file="${MODEL_DIR}/${lang}3g.bo"
    lm_file="${MODEL_DIR}/${lang}3g.arpa"
    
    echo "Construction du modèle de caractères pour $lang..."
    ngram-count -order 3 -text "$train_file" -write "$bo_file" -write-vocab "$vocab_file"
    ngram-count -read "$bo_file" -lm "$lm_file" -gt2min 1 -gt3min 2
done