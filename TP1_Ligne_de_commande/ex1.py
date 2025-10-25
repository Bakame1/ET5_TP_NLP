# Read the input file
with open('RADIOS.txt', 'r', encoding='utf-8') as file:
    content = file.read()

#Mettre en MAJ
content = content.upper()

# Écrire les résultats dans le fichier de sortie
with open('RADIOS_UPPER.txt', 'w', encoding='utf-8') as file:
    file.write(content)