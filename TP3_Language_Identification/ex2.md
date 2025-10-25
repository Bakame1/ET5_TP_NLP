
### Exec buid build_trigram_model.bash

### Q1 : Observez les fichiers .voc , .bo et .BO ; que contiennent ils ?

Fichier .voc : Ce fichier contient le vocabulaire utilisé dans le modèle de langue. Il liste tous les mots (ou tokens) uniques trouvés dans le texte d'entraînement.

Fichier .bo : Ce fichier contient les comptes de n-grammes (dans ce cas, des trigrammes) sous une forme binaire. Il est utilisé comme entrée pour créer le modèle de langue.

Fichier .BO : Ce fichier contient le modèle de langue proprement dit, avec les probabilités des n-grammes. La première colonne de ce fichier est homogène au logarithme d'une probabilité.

### Q2
```
<s> : Marque le début d'une phrase.
</s> : Marque la fin d'une phrase
```
### Q3 : `A quoi servent les options -gt2min et -gt3min ? Dans quels cas elles sont utiles/n´ecessaires ?
Les options -gt2min et -gt3min servent à spécifier les seuils minimaux pour les bigrammes et les trigrammes, respectivement.

-gt2min 1 : Tout bigramme qui apparaît moins de 2 fois dans le texte d'entraînement sera ignoré ou traité différemment.
-gt3min 2 : Tout trigramme qui apparaît moins de 3 fois dans le texte d'entraînement sera ignoré ou traité différemment.

Ces options sont utiles pour éviter le surajustement des données d'entraînement en excluant les n-grammes qui apparaissent très rarement, ce qui peut rendre le modèle plus robuste et mieux capable de généraliser à de nouvelles données. Elles sont particulièrement nécessaires lorsque le texte d'entraînement est de taille limitée ou lorsque certains n-grammes apparaissent très rarement.
Si vous avez d'autres questions ou besoin de plus de détails, n'hésitez pas à demander !
### Q4 trigram le plus freq => most_frequent_trigram
```
perl -ne 'if (/\\3-grams:/) {$print = 1; print; next} if ($print) {print}' fr3g.bo > trigrams.txt
```
```
sort -n trigrams.txt > trigrams_sorted.txt
```
```
head -n 1 trigrams_sorted.txt
```

