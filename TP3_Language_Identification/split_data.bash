#!/bin/bash

# Chemin vers le dossier contenant les fichiers de langue
LANG_DIR="lang"

# Chemin vers le dossier de destination pour les fichiers séparés
SPLITED_DATA_DIR="splited_data"

# Vérifier si le dossier de langue existe
if [ ! -d "$LANG_DIR" ]; then
    echo "Le dossier $LANG_DIR n'existe pas."
    exit 1
fi

# Créer le dossier de destination s'il n'existe pas
mkdir -p "$SPLITED_DATA_DIR"

# Parcourir chaque fichier dans le dossier de langue
for file in "$LANG_DIR"/*.txt; do
    # Extraire le nom de la langue (sans l'extension .txt)
    lang=$(basename "$file" .txt)

    # Nom du fichier d'entraînement
    train_file="${SPLITED_DATA_DIR}/train.${lang}"

    # Nom du fichier de test
    test_file="${SPLITED_DATA_DIR}/test.${lang}"

    # Nombre total de lignes dans le fichier
    total_lines=$(wc -l < "$file")

    # Nombre de lignes pour chaque partie (la moitié)
    half_lines=$((total_lines / 2))

    # Couper le fichier en deux parties
    head -n "$half_lines" "$file" > "$train_file"
    tail -n "$half_lines" "$file" > "$test_file"

    # Afficher un message de confirmation
    echo "Fichier $file coupé en $train_file et $test_file"
done
