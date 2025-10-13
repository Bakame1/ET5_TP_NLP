### Activer environnement
```
venv\Scripts\activate
```

### Installer lib necessaires
```
pip install -r requirements.txt
```

### Avant lancer sentiment_analysis_classification_cnn_lstm.py avec MMNLU_FR, transformer les fichiers en CSV
```
.venv\Scripts\python.exe merge_data_to_csv.py
```

### Lancer  sentiment_analysis_classification_cnn_lstm.py avec les differents parametres


Exemples pour cnn : 

```
.venv\Scripts\python.exe sentiment_analysis_classification_cnn_lstm.py \
  --model lstm \
  --train datasets/MMNLU_FR/train.csv \
  --valid datasets/MMNLU_FR/dev.csv \
  --test datasets/MMNLU_FR/test.csv \
  --epochs 10
```

```
python sentiment_analysis_classification_cnn_lstm.py \
  --model cnn \
  --train datasets/movie_reviews_fr/train.csv \
  --valid datasets/movie_reviews_fr/dev.csv \
  --test datasets/movie_reviews_fr/test.csv \
  --epochs 10
```

```
  python sentiment_analysis_classification_cnn_lstm.py \
  --model cnn \
  --train datasets/twitter_sentiment_analysis_en/train.csv \
  --valid datasets/twitter_sentiment_analysis_en/dev.csv \
  --test datasets/twitter_sentiment_analysis_en/test.csv \
  --epochs 10
```


## Partie DL - etapes
### Étape 1 : Charger les données (Load the data)
### Étape 2 : Définir les modèles DL & ML (Define DL & ML models)
```
class SentimentModelLSTM(nn.Module):
    - Embedding layer (100 dimensions)
    - LSTM layer (128 hidden units, 1 layer)
    - Dropout (0.3)
    - Fully connected layer
    - Sigmoid activation (classification binaire)
```
```
class SentimentModelCNN(nn.Module):
    - Embedding layer (100 dimensions)
    - 3 convolution layers (kernels 3, 4, 5)
    - Max pooling
    - Dropout (0.2)
    - Fully connected layer
```
### Étape 3 : Entraîner les modèles CNN & LSTM (Train models)
```
.venv\Scripts\python.exe sentiment_analysis_classification_cnn_lstm.py --model lstm --train datasets/MMNLU_FR/train.csv --valid datasets/MMNLU_FR/dev.csv --test datasets/MMNLU_FR/test.csv --epochs 10
```
```
.venv\Scripts\python.exe sentiment_analysis_classification_cnn_lstm.py --model cnn --train datasets/MMNLU_FR/train.csv --valid datasets/MMNLU_FR/dev.csv --test datasets/MMNLU_FR/test.csv --epochs 10
```
Ce qui se passe pendant l'entraînement :
* Forward pass : Le modèle fait des prédictions
* Calcul de la perte : Compare prédictions vs vraies valeurs
* Backpropagation : Calcule les gradients
* Mise à jour des poids : Optimizer (Adam) ajuste les paramètres
* Validation : Évalue les performances sur le set de validation
* Early stopping : Arrête si pas d'amélioration pendant 5 époques

### Après 1er entrainement 
1. Déséquilibre de classes très important
Regardez la distribution :
* Classe 35 : 810 exemples (la plus fréquente)
* Classe 48 : 4 exemples seulement
* Classe 23 : 14 exemples

Le modèle sur-apprend la classe majoritaire.
2. Le modèle ne converge pas

* Train Accuracy : 6% (devrait augmenter à chaque époque)
* Validation Accuracy : 1.3% (extrêmement faible)
* Le modèle prédit toujours la classe 35 (recall 100% pour classe 35)

3. Avertissement sur le dropout
```
dropout=0.25 and num_layers=1
```
Le dropout LSTM ne fonctionne que si n_layers > 1.

Solution : 
n_layers = 2  # AU LIEU DE 1
lr = 1e-3  # AU LIEU DE 1e-4

#### ON decide de modifier train_x avec du Random Oversampling (Simple) : Dupliquer les exemples des classes minoritaires 

### Après 2e entrainement, parametres à modifier
Paramètre       |  Avant  |  Après  |  Raison                                          
----------------+---------+---------+--------------------------------------------------
lr              |  1e-4   |  1e-3   |  Learning rate trop faible → modèle n'apprend pas
n_layers        |  1      |  2      |  Dropout LSTM nécessite 2+ layers                
embedding_size  |  100    |  256    |  Représentation des mots trop simple             
hidden_size     |  128    |  256    |  Capacité du modèle insuffisante                 
batch_size      |  128    |  64     |  Batch trop grand → gradient imprécis            


1. embedding_size (Taille de l'embedding)
Définition : C'est la dimension du vecteur qui représente chaque mot de votre vocabulaire.
Analogie : Imaginez que chaque mot est un point dans un espace multidimensionnel. L'embedding_size définit combien de dimensions utiliser pour représenter ce mot.

Exemple concret :

    Vocabulaire : 8,141 mots uniques=
    embedding_size = 100 → chaque mot devient un vecteur de 100 nombres
    Le mot "bonjour" → [0.23, -0.45, 0.67, ..., 0.12] (100 valeurs)
Pourquoi augmenter de 100 à 256 ?

    100 dimensions : Représentation simple, peut perdre des nuances sémantiques

    256 dimensions : Représentation plus riche, capture mieux les relations entre mots (synonymes, antonymes, contexte)

Impact : Plus grande = meilleure capacité à distinguer les mots similaires, mais plus de paramètres à entraîner.
​
2. hidden_size (Taille de l'état caché)

Définition : C'est le nombre de neurones dans chaque couche LSTM, qui définit la capacité de mémoire du réseau.


Analogie : C'est comme la taille de la "mémoire de travail" du modèle. Plus c'est grand, plus le modèle peut retenir d'informations complexes sur la séquence.

Dans votre code :

python
self.lstm = nn.LSTM(embedding_size, hidden_size, ...)

    Input : vecteur de embedding_size dimensions (256)

    Processing : hidden_size neurones (256) traitent l'information

    Output : vecteur de hidden_size dimensions (256)

Pourquoi augmenter de 128 à 256 ?

    128 neurones : Capacité limitée pour 60 classes complexes

    256 neurones : Plus de capacité pour apprendre des patterns subtils dans les intentions françaises

Impact : Plus grand = modèle plus puissant mais plus lent à entraîner et risque d'overfitting.

​
3. batch_size (Taille du lot)

Définition : C'est le nombre d'exemples traités simultanément avant de mettre à jour les poids du réseau.

​

Processus d'entraînement :

    Le modèle prend 64 exemples (batch_size = 64)

    Calcule la perte pour ces 64 exemples

    Calcule le gradient moyen

    Met à jour les poids

    Répète avec les 64 exemples suivants

Votre dataset après oversampling :

    Total : 48,600 exemples (810 × 60 classes)

    batch_size = 64 → 759 batches par époque

    batch_size = 128 → 380 batches par époque



