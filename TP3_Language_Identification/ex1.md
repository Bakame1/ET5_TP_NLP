## Q1
On utilise des textes différents pour l'apprentissage et le test afin de pouvoir évaluer la performance du modèle sur des données qu'il n'a pas vues pendant l'entraînement. Cela permet de s'assurer que le modèle est capable de généraliser et non pas simplement de mémoriser les données d'entraînement.

### On compte le nb de mot
```
wc -l lang/fr.txt
```
Ici on obtient 20000

### Decoupage en 
```
head -n 10000 lang/fr.txt > splited_data/train.fr
```
```
tail -n 10000 lang/fr.txt > splited_data/test.fr
```

## exec => split_data.bash
