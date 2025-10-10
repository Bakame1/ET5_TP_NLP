#!/bin/bash
# Tester le modèle fastText et générer la matrice de confusion

DATA_DIR="fasttext_data"
MODEL_DIR="fasttext_models"
TEST_DIR="splited_data"

MODEL_FILE="${MODEL_DIR}/lang_id.bin"
TEST_FILE="${DATA_DIR}/test.txt"

echo "================================================"
echo "Test du modèle fastText - Performance globale"
echo "================================================"
echo ""

# Test automatique avec précision/rappel
fasttext test "$MODEL_FILE" "$TEST_FILE"

echo ""
echo "================================================"
echo "Matrice de confusion détaillée"
echo "================================================"
echo ""

# Créer un fichier temporaire pour les prédictions
PRED_FILE="${MODEL_DIR}/predictions.txt"

# Prédire les labels
fasttext predict "$MODEL_FILE" "$TEST_FILE" > "$PRED_FILE"

# Extraire les vrais labels
TRUE_LABELS="${MODEL_DIR}/true_labels.txt"
cut -d' ' -f1 "$TEST_FILE" > "$TRUE_LABELS"

# Script Python pour générer la matrice de confusion
python3 - <<EOF
import sys
from collections import defaultdict

# Lire les vrais labels et les prédictions
with open('${TRUE_LABELS}', 'r') as f:
    true_labels = [line.strip() for line in f]

with open('${PRED_FILE}', 'r') as f:
    pred_labels = [line.strip() for line in f]

# Extraire les codes de langue (enlever __label__)
true_langs = [label.replace('__label__', '') for label in true_labels]
pred_langs = [label.replace('__label__', '') for label in pred_labels]

# Créer la matrice de confusion
confusion = defaultdict(lambda: defaultdict(int))
for true, pred in zip(true_langs, pred_langs):
    confusion[true][pred] += 1

# Obtenir la liste des langues
languages = sorted(set(true_langs))

# Afficher la matrice
print("Matrice de confusion (lignes = vraies langues, colonnes = prédictions)")
print("")
print("     ", end="")
for lang in languages:
    print(f"{lang:>8}", end="")
print("  | Total")
print("-" * (9 + 8 * len(languages) + 10))

for true_lang in languages:
    print(f"{true_lang:>4} ", end="")
    total = 0
    for pred_lang in languages:
        count = confusion[true_lang][pred_lang]
        total += count
        if true_lang == pred_lang:
            print(f"\033[92m{count:>8}\033[0m", end="")  # Vert pour diagonale
        else:
            print(f"{count:>8}", end="")
    print(f"  | {total}")

print("")
print("Précision par langue:")
for lang in languages:
    correct = confusion[lang][lang]
    total = sum(confusion[lang].values())
    accuracy = (correct / total * 100) if total > 0 else 0
    print(f"  {lang}: {correct}/{total} = {accuracy:.2f}%")

print("")
print("Précision globale:")
total_correct = sum(confusion[lang][lang] for lang in languages)
total_samples = sum(sum(confusion[lang].values()) for lang in languages)
global_accuracy = (total_correct / total_samples * 100) if total_samples > 0 else 0
print(f"  {total_correct}/{total_samples} = {global_accuracy:.2f}%")

EOF

echo ""
echo "✅ Analyse terminée !"