#!/bin/bash

# Chemin vers le dossier contenant les fichiers .bo
MODEL_DIR="trigram_models"

# Parcours de chaque fichier .bo dans le répertoire des modèles
for lm_file in "$MODEL_DIR"/*.bo; do
  # Vérifier que le fichier existe
  [ -f "$lm_file" ] || continue

  # Extraction du nom de la langue depuis le nom du fichier
  lang=$(basename "$lm_file" | cut -d. -f1 | sed 's/3g//')

  echo "Le trigramme de mots le plus fréquent pour $lang est :"

  # Utiliser awk pour traiter chaque ligne, extraire les trigrammes et leurs fréquences, puis trier et afficher le plus fréquent
  awk -F'\t' '{
    if (NF == 2) {
      trigram = $1;
      freq = $2;
      # Vérifier que le trigramme contient exactement trois mots
      if (trigram ~ /^([^ ]+ ){2}[^ ]+$/) {
        print freq "\t" trigram;
      }
    }
  }' "$lm_file" | sort -nr | head -n 1 | awk -F'\t' '{print $2 "\t" $1}'
done
