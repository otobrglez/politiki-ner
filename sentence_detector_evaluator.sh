#!/usr/bin/env bash

apache-opennlp/bin/opennlp  SentenceDetectorEvaluator -encoding UTF-8 -model models/si-sent.bin -data models/news-sentence.eval
