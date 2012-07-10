# Politiki Named Entity Recognition API

Project goal is to make fast and reliable API that can extract people/politicians, political parties and locations from Slovenian news "streams". This project is part of project [Politiki.si](http://politiki.si).

## Tools 

Project uses jRuby to wrap OpenNLP framework to do magic stuff with it. Since this project is "optimized" for Heroku infrastructure all "learning" part must take place before uploading project to Heroku infrastructure. (See models folder for more information). Project is specialized for Slovenian language with political news knowladge domain.

## API 

API system uses REST structure.

### POST /sentence_detector

For sentence detection and spliting use '/sentence_detector' method.

	curl http://politiki-si-ner.herokuapp.com/sentence_detector \
    -d "text=Delo vlade kot neuspešno ocenjuje 63,7 odstotka vprašanih, kot uspešno pa 28,6 odstotka. Neopredeljenih je 7,7 odstotka vprašanih. Delo predsednika vlade Janeza Janše je na lestvici, kjer je najslabša ocena 1 in najboljša ocena 5, ocenjeno s povprečno oceno 2,73."
    
    {"sentences":
    [
    "Delo vlade kot neuspešno ocenjuje 63,7 odstotka vprašanih, kot uspešno pa 28,6 odstotka.",
    "Neopredeljenih je 7,7 odstotka vprašanih.",
    "Delo predsednika vlade Janeza Janše je na lestvici, kjer je najslabša ocena 1 in najboljša ocena 5, ocenjeno s povprečno oceno 2,73."
    ]}

### POST /tokenize

To do text tokenization use '/tokenize' method like so.
    
	curl http://politiki-si-ner.herokuapp.com/tokenize \
    -d "text=Zanima me če tokenizacija zares deluje?" 

	{"tokens":["Zanima","me","če","tokenizacija","zares","deluje","?"]}

### POST /ner

Working on this baby :P

	curl http://politiki-si-ner.herokuapp.com/ner \
    -d "text=... article goes here ..."
    
    {"parties".... "politicians".... 

## Some links

* [Apache OpenNLP](http://opennlp.apache.org/)
* [jRuby](http://jruby.org/)
* [Heroku jRuby Build Pack](https://github.com/carlhoerberg/heroku-buildpack-jruby)

## Contact me && || give me job. ;)

Oto Brglez / [@otobrglez](http://opalab.com)