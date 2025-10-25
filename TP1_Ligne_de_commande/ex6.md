## TEST
### recupere les 'print dans le fichier test.txt
```
awk '{print $1}' test.txt
```

### displays the words whose number of occurrences > 100 in RADIOS.txt
```
awk '$1 > 100 { print $0}' RADIOS.hist
```
## Q1 Find the bi-grams that appear exactly 13 times

### Bigrams (n=2)
```
tr -s '[:space:]' '\n' < RADIOS.txt | paste -d ' ' - - | sort | uniq -c | sort -nr > bigrams.hist
```
### Exactement 3 bigrams
```
awk '$1 ==3 { print $0}' bigrams.hist
```
## Q2 : Find the palindromes in RADIOS.txt
```
awk '{print $2}' RADIOS.hist | rev | paste - <(awk '{print $2}' RADIOS.hist) | awk '$1 == $2 {print$2}'
```
{print$2} : affiche uniquement le 2e mot mis a l'envers pour eviter d'avoir 2 col