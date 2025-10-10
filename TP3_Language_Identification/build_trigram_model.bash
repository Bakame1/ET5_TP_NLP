#!/bin/bash

# Chemin vers le dossier contenant les fichiers d'entraînement
TRAIN_DIR="splited_data"

# Chemin vers le dossier de destination pour les modèles
MODEL_DIR="trigram_models"

# Vérifier si le dossier d'entraînement existe
if [ ! -d "$TRAIN_DIR" ]; then
    echo "Le dossier $TRAIN_DIR n'existe pas."
    exit 1
fi

# Créer le dossier de destination s'il n'existe pas
mkdir -p "$MODEL_DIR"

# Parcourir chaque fichier d'entraînement dans le dossier
for train_file in "$TRAIN_DIR"/train.*; do
    # Vérifier si le fichier existe
    if [ ! -f "$train_file" ]; then
        continue
    fi

    # Extraire le nom de la langue (sans le préfixe 'train.')
    lang=$(basename "$train_file" | cut -d. -f2)

    # Nom du fichier de vocabulaire
    vocab_file="${MODEL_DIR}/${lang}.voc"

    # Nom du fichier de comptes de trigrammes
    bo_file="${MODEL_DIR}/${lang}3g.bo"

    # Nom du fichier du modèle de langue
    lm_file="${MODEL_DIR}/${lang}3g.arpa"

    # Construire le modèle de langue à trigrammes
    echo "Construction du modèle de langue pour $lang..."
    ngram-count -order 3 -text "$train_file" -write "$bo_file" -write-vocab "$vocab_file"
    ngram-count -read "$bo_file" -lm "$lm_file" -gt2min 1 -gt3min 2
done
