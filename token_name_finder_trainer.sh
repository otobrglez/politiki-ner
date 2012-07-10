#!/usr/bin/env bash

apache-opennlp/bin/opennlp TokenNameFinderTrainer \
 -encoding UTF-8 \
 -lang si \
 -data models/news-ner-person.raw.PRE \
 -iterations 50 \
 -model models/si-ner.bin

