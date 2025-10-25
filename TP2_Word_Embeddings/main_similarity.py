from load_2_2 import load
from cos import cosine_similarity_numpy,cosine_similarity_scipy

# Charge les vecteurs à partir du fichier
vocab, rev_vocab, vectors = load('model_cbow_text8.vec')

#Récupérer les indices des mots "dog", "cat", et "dentist"
index_dog = vocab['dog']
index_cat = vocab['cat']
index_dentist = vocab['dentist']

# Récupérer les vecteurs correspondants
vector_dog = vectors[index_dog]
vector_cat = vectors[index_cat]
vector_dentist = vectors[index_dentist]

# Calculer la similarité cosinus entre "dog" et "cat"
cos_sim_dog_cat = cosine_similarity_numpy(vector_dog, vector_cat)

# Calculer la similarité cosinus entre "dog" et "dentist"
cos_sim_dog_dentist = cosine_similarity_numpy(vector_dog, vector_dentist)

print(f"Similarité cosinus entre 'dog' et 'cat' : {cos_sim_dog_cat}")
print(f"Similarité cosinus entre 'dog' et 'dentist' : {cos_sim_dog_dentist}")

#################################### QUESTION 4 ####################################
# Récupérer les indices des mots "bank", "river", et "trade"
index_bank = vocab['bank']
index_river = vocab['river']
index_trade = vocab['trade']

# Récupérer les vecteurs correspondants
vector_bank = vectors[index_bank]
vector_river = vectors[index_river]
vector_trade = vectors[index_trade]

# Calculer la similarité cosinus entre "bank" et "river"
cos_sim_bank_river = cosine_similarity_numpy(vector_bank, vector_river)

# Calculer la similarité cosinus entre "bank" et "trade"
cos_sim_bank_trade = cosine_similarity_numpy(vector_bank, vector_trade)

print(f"Similarité cosinus entre 'bank' et 'river' : {cos_sim_bank_river}")
print(f"Similarité cosinus entre 'bank' et 'trade' : {cos_sim_bank_trade}")

if cos_sim_bank_river > cos_sim_bank_trade:
    print("Le mot le plus proche de 'bank' est 'river'.")
else:
    print("Le mot le plus proche de 'bank' est 'trade'.")