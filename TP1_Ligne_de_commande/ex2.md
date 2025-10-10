### 20 premieres lignes
```
cat RADIOS.txt | head -n 20
```
### Compte les mots puis stocke
Le -c dans unique compte les mots
```
tr -s '[:space:]' '\n' < RADIOS.txt | sort | uniq -c > RADIOS.hist 
```
