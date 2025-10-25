from load_2_2 import load
from closest import closest



def main_closest (word):
    # Charge les vecteurs à partir du fichier
    vocab, rev_vocab, vectors = load('model_cbow_text8.vec')
    #Récupérer vect word
    index_word = vocab[word]
    vector_word = vectors[index_word]

    # Récupérer les mots les plus proches de pomme
    closest_to_word = closest(vectors,vector_word)

    # Affiche les résultats
    print(f"Mots les plus proches de {word} :")
    for score, index in closest_to_word:
        # Affiche le mot et son score de similarité
        print(f"Mot: {rev_vocab[index]}, Score: {score}")

########################## Q1 ##########################
#main_closest("apple")
########################## Q2 ##########################
main_closest("microsoft")