## Intro

The sed tool allows you to replace text using regular expressions. 
Thus, the command sed 's/exp1/exp2/[op
replace (s) the expression exp1 by the expression exp2. The option is often the letter g to say that all occurrences on the same line should be replaced.

or example :
— sed 's/[éèêë]/e/g' replaces all accented letters "e" with an unaccented letter
— sed 's/ \([ˆ]*\)ation / \U\1ATION/g' transforms the words which end with the suffix
"ation" into capital letters, for example, "habitation" becomes "HABITATION"

### Question 1 : Ajouter un point à la fin de chaque ligne et mettre la première lettre en majuscule
```
sed -e '/./s/$/./' -e '/./s/^./\U&/' RADIOS.txt
```

## Question 2 : Remplacer toute occurrence de deux mots consécutifs identiques par une seule occurrence de ce mot
```
sed 's/\([^ ]\+\) \1/\1/g' RADIOS.txt
```

