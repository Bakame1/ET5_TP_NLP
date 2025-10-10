#!/bin/bash
# compute_char_perplexity.sh
MODEL_DIR="char_trigram_models_space"
TEST_DIR="char_data_space_token"

for arpa_file in "$MODEL_DIR"/*.arpa; do
  for test_file in "$TEST_DIR"/test.*; do
    echo "Modèle $arpa_file vs Test $test_file :"
    ngram -lm "$arpa_file" -ppl "$test_file"
    echo
  done
done