## Q1
### words of 9 letter
```
tr -s '[:space:]' '\n' < RADIOS.txt | grep '^.\{9\}$' > NINE.hist
```
### How many words
```
cat NINE.hist |wc -l
```
## Q2
### words without voyel
```
tr -s '[:space:]' '\n' < RADIOS.txt | grep -i  '^[^aeiouAEIOUéèàyôâêëîïûü]$' > voyel.hist
```

-v : Cette option inverse la correspondance, ce qui signifie que grep sélectionne les lignes qui ne correspondent pas au motif donné. Dans notre cas, nous voulons les mots qui ne contiennent aucune voyelle, donc nous utilisons -v pour exclure les lignes qui contiennent des voyelles.
-i : Cette option ignore la casse, ce qui signifie que grep traite les lettres majuscules et minuscules de la même manière. Cela permet de capturer toutes les voyelles, qu'elles soient en majuscules ou en minuscules.

### How many words
```
cat voyel.hist |wc -l
```