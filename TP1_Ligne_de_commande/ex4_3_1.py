# Lire le fichier d'entrée
with open('RADIOS.txt', 'r', encoding='utf-8') as file:
    content = file.read()

# Diviser le contenu en mots
words = content.split()

# Compter les occurrences de chaque mot
word_counts = {}
for word in words:
    if word in word_counts:
        word_counts[word] += 1
    else:
        word_counts[word] = 1

# Q1 : Trier les mots par fréquence d'apparition (décroissante)
with open('RADIOS_frequency.hist', 'w', encoding='utf-8') as file:
    for word, count in sorted(word_counts.items(), key=lambda item: item[1], reverse=True):
        file.write(f"{word}: {count}\n")

# Q2 : Trier les mots par ordre alphabétique
with open('RADIOS_alphabetical.hist', 'w', encoding='utf-8') as file:
    for word in sorted(word_counts.keys()):
        file.write(f"{word}\n")

# Q3 : Trier les mots par ordre "rimé" (regrouper les mots avec la même terminaison)
# Obtenir les mots uniques pour éviter les répétitions
unique_words = list(word_counts.keys())

# Trier par la terminaison des mots
rhymic_order = sorted(unique_words, key=lambda word: word[::-1])

with open('RADIOS_rhymic.hist', 'w', encoding='utf-8') as file:
    for word in rhymic_order:
        file.write(f"{word}\n")

# Bonus : Filtrer et trier uniquement les mots se terminant par "-ment"
ment_words = [word for word in unique_words if word.endswith('ment')]
ment_words_sorted = sorted(ment_words)

with open('RADIOS_ment.hist', 'w', encoding='utf-8') as file:
    for word in ment_words_sorted:
        file.write(f"{word}\n")
