#!/bin/bash

DESTINATION="$HOME/Tools/fasttext"
rm -rf "$DESTINATION"
mkdir -pv "$DESTINATION"

echo "Ajout des variables d'environnement dans ~/.bashrc"
echo "export PATH=\$PATH:$DESTINATION" >> ~/.bashrc
echo "export FASTTEXT=$DESTINATION" >> ~/.bashrc

# Recharger le bashrc
source ~/.bashrc

pushd "$DESTINATION"
    # Cloner le dépôt FastText
    git clone https://github.com/facebookresearch/fastText.git
    cd fastText
    
    # Compiler FastText
    make -j4
    
    # Copier le binaire dans le dossier de destination
    cp fasttext "$DESTINATION"
popd

# Recharger à nouveau pour s'assurer que le PATH est à jour
source ~/.bashrc

echo "Installation de FastText terminée !"
echo "Le binaire se trouve dans : $DESTINATION"

# Tester si fasttext est accessible
if command -v fasttext &> /dev/null; then
    echo "Vérification de l'installation :"
    fasttext
else
    echo "FastText installé mais pas dans le PATH actuel."
    echo "Ouvrez un nouveau terminal ou exécutez: source ~/.bashrc"
    echo "Vous pouvez aussi l'exécuter directement avec: $DESTINATION/fasttext"
fi