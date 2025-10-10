import numpy as np

def load(filename):
    vocab = {}          # Dictionnaire pour mapper les mots à leurs indices
    rev_vocab = []      # Liste pour mapper les indices aux mots
    lines = open(filename).readlines()  # Lit toutes les lignes du fichier
    # Initialise la matrice de vecteurs avec les dimensions de la première ligne
    vectors = np.zeros((int(lines[0].split()[0]), int(lines[0].split()[1])))
    for i, line in enumerate(lines):
        tokens = line.strip().split()  # Sépare la ligne en tokens
        if (i > 0):  # Ignore la première ligne (en-tête)
            vocab[tokens[0]] = i-1  # Mappe le mot à son indice
            rev_vocab.append(tokens[0])  # Ajoute le mot à la liste de vocabulaire inversé
            vectors[i-1] = [float(value) for value in tokens[1:]]  # Stocke les vecteurs
    return vocab, rev_vocab, vectors

"""
# Charge les vecteurs à partir du fichier
vocab, rev_vocab, vectors = load('model_cbow_text8.vec')

# Exemple d'accès aux vecteurs
print(vocab['the'])  # Affiche l'indice du mot 'the'
print(rev_vocab[0])  # Affiche le mot à l'indice 0
print(vectors[0])    # Affiche le vecteur du mot à l'indice 0
"""

"""
ON OBTIENT : 
0  
the
[ 0.18402    2.616     -3.9649     2.4161    -2.8981     0.074244
  0.57689    1.9147    -0.70638    1.176     -0.42784    0.90325
 -2.061      1.2267    -2.0779     0.80224    0.69738   -1.5454
 -1.1181     0.17399    1.4773     3.0466     1.3137    -1.2307
 -0.0077562 -0.039098   0.8301     0.29179    1.8173     0.17318
  0.992     -2.2089     1.7364     1.9248    -1.0229    -0.11292
 -0.35819    2.7648    -0.27119   -1.3713    -2.8202     0.20487
 -3.7134    -1.5469     2.0898     0.22092   -0.16992    0.96053
  0.018529   1.6576   ]
"""