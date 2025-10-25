#!/bin/bash
# Entraîner le modèle fastText pour classification de langue

DATA_DIR="fasttext_data"
MODEL_DIR="fasttext_models"

mkdir -p "$MODEL_DIR"

TRAIN_FILE="${DATA_DIR}/train.txt"
MODEL_FILE="${MODEL_DIR}/lang_id"

echo "Entraînement du modèle fastText..."
echo ""

# Entraînement en mode supervised
fasttext supervised \
    -input "$TRAIN_FILE" \
    -output "$MODEL_FILE" \
    -lr 0.5 \
    -epoch 25 \
    -wordNgrams 2 \
    -dim 100 \
    -loss softmax

echo ""
echo "✅ Modèle entraîné : ${MODEL_FILE}.bin"