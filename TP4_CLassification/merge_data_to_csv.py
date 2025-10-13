import pandas as pd
import os

def prepare_dataset(data_dir, split_name, output_file):
    """
    Fusionne les fichiers label et seq.in en un seul CSV
    
    Args:
        data_dir: Chemin vers le dossier (ex: 'datasets/MMNLU_FR/train')
        split_name: 'train', 'dev', ou 'test'
        output_file: Nom du fichier CSV de sortie
    """
    # Chemins des fichiers
    label_file = os.path.join(data_dir, split_name, 'label')
    seqin_file = os.path.join(data_dir, split_name, 'seq.in')
    
    # Lecture des fichiers (une ligne = une entrée)
    with open(label_file, 'r', encoding='utf-8') as f:
        labels = [line.strip() for line in f.readlines()]
    
    with open(seqin_file, 'r', encoding='utf-8') as f:
        reviews = [line.strip() for line in f.readlines()]
    
    # Vérification que les longueurs correspondent
    assert len(labels) == len(reviews), f"Nombre de labels ({len(labels)}) != nombre de reviews ({len(reviews)})"
    
    # Création du DataFrame
    df = pd.DataFrame({
        'review': reviews,
        'label': labels
    })
    
    # Conversion des labels en entiers (si nécessaire)
    # Si vos labels sont déjà des catégories textuelles, créez un mapping
    label_mapping = {label: idx for idx, label in enumerate(df['label'].unique())}
    df['label'] = df['label'].map(label_mapping)
    
    # Sauvegarde en CSV
    df.to_csv(output_file, index=False)
    print(f"✓ {output_file} créé avec {len(df)} entrées")
    print(f"  Nombre de classes: {len(label_mapping)}")
    print(f"  Mapping: {label_mapping}")
    
    return df

data_selected = input("Veuillez selectionner le dossier de votre dataset : \n=> MMNLU_FR\n=> movie_reviews_fr \n=> twitter_sentiment_analysis_en\n\nChoix : ")
# Préparation des 3 splits pour MMNLU_FR
base_dir = 'datasets/'+data_selected

#MMNLU_FR
#movie_reviews_fr
#twitter_sentiment_analysis_en

print(f"Préparation du dataset {base_dir}...")
train_df = prepare_dataset(base_dir, 'train', base_dir+'/train.csv')
dev_df = prepare_dataset(base_dir, 'dev', base_dir+'/dev.csv')
test_df = prepare_dataset(base_dir, 'test', base_dir+'/test.csv')

print(f"\nTous les fichiers CSV du dataset {base_dir} sont prêts!")
