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



.venv\Scripts\python.exe sentiment_analysis_classification_cnn_lstm.py --model lstm --train datasets/MMNLU_FR/train.csv --valid datasets/MMNLU_FR/dev.csv --test datasets/MMNLU_FR/test.csv --epochs 20

...
456
789