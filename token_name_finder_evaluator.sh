#!/usr/bin/env bash

apache-opennlp/bin/opennlp TokenNameFinderEvaluator -encoding UTF-8 -model models/si-ner-party.bin -data models/news-ner.test
