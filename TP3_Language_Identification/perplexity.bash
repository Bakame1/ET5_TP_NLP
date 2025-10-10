#!/bin/bash
MODEL_DIR="trigram_models"
TEST_DIR="splited_data"

for arpa_file in "$MODEL_DIR"/*.arpa; do
  for test_file in "$TEST_DIR"/test.*; do
    echo "Modèle $arpa_file vs Test $test_file :"
    ngram -lm "$arpa_file" -ppl "$test_file"
    echo
  done
done
