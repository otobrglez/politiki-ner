#!/usr/bin/env bash

apache-opennlp/bin/opennlp TokenizerTrainer -encoding UTF-8 -lang si -data models/news-token.train -model models/si-token.bin
