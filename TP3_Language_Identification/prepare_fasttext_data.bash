#!/bin/bash
# Préparer les données pour fastText avec labels

TRAIN_DIR="splited_data"
OUTPUT_DIR="fasttext_data"

mkdir -p "$OUTPUT_DIR"

# Fichiers de sortie
TRAIN_FILE="${OUTPUT_DIR}/train.txt"
TEST_FILE="${OUTPUT_DIR}/test.txt"

# Nettoyer les fichiers de sortie s'ils existent
> "$TRAIN_FILE"
> "$TEST_FILE"

echo "Préparation des données d'entraînement..."

# Parcourir tous les fichiers d'entraînement
for train_file in "$TRAIN_DIR"/train.*; do
    if [ ! -f "$train_file" ]; then
        continue
    fi
    
    # Extraire le code de langue
    lang=$(basename "$train_file" | cut -d. -f2)
    
    echo "  Ajout de $lang (train)..."
    
    # Ajouter le label __label__XX devant chaque ligne
    sed "s/^/__label__${lang} /" "$train_file" >> "$TRAIN_FILE"
done

echo "Préparation des données de test..."

# Parcourir tous les fichiers de test
for test_file in "$TRAIN_DIR"/test.*; do
    if [ ! -f "$test_file" ]; then
        continue
    fi
    
    # Extraire le code de langue
    lang=$(basename "$test_file" | cut -d. -f2)
    
    echo "  Ajout de $lang (test)..."
    
    # Ajouter le label __label__XX devant chaque ligne
    sed "s/^/__label__${lang} /" "$test_file" >> "$TEST_FILE"
done

echo ""
echo "✅ Préparation terminée !"
echo "Fichier d'entraînement : $TRAIN_FILE"
echo "Fichier de test : $TEST_FILE"
echo ""
echo "Statistiques :"
wc -l "$TRAIN_FILE" "$TEST_FILE"