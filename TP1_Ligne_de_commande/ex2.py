# Read the input file
with open('RADIOS.txt', 'r', encoding='utf-8') as file:
    content = file.read()

# Split the content into words
words = content.split()

words_counts = {}
for word in words :
    if word in words_counts :
        words_counts[word] +=1
    else:
        words_counts[word] = 1
#print(words_counts)

# Écrire les résultats dans le fichier de sortie
with open('RADIOS.hist', 'w', encoding='utf-8') as file:
    for word, count in sorted(words_counts.items()):
        file.write(f"{word}: {count}\n")

"""
4.2.1 Questions :
— Q1 : What word appears exactly 1,732 times in this text ?
— Q2 : How many times does the word "orange" appear in this text ?
"""

# Q1 : Trouver le mot qui apparaît exactement 1 732 fois
word_1732 = [word for word, count in words_counts.items() if count == 1732]
print(f"Q1 : Le mot qui apparaît exactement 1 732 fois est : {word_1732}")

# Q2 : Nombre d'occurrences du mot "orange"
orange_count = words_counts.get("orange", 0)
print(f"Q2 : Le mot 'orange' apparaît {orange_count} fois dans le texte.")
