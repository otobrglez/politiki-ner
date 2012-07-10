# Politiki Named Entity Recognition API

Project goal is to make fast and reliable API that can extract people/politicians, political parties and locations from Slovenian news "streams". This project is part of project [Politiki.si](http://politiki.si).

## Tools 

Project uses jRuby to wrap OpenNLP framework to do magic stuff with it. Since this project is "optimized" for Heroku infrastructure all "learning" part must take place before uploading project to Heroku infrastructure. (See models folder for more information). Project is specialized for Slovenian language with political news knowladge domain.

## API 

API system uses REST structure.

### POST /ner

Named Entity Recognition is done with POST to '/ner'. Result is JSON with "text" and "entities".

* "text" contains list of sentences.
* "entities" contains lists of parties, persons, locations, ...

Named Entity Recognition is based oponce learining and analysis, quality of results is based oponce gethered knowladge.

    curl http://politiki-si-ner.herokuapp.com/ner \
    -d "text=Predsedstvo SD je Boruta Pahorja potrdilo za kandidata stranke za predsednika države z le enim glasom proti. 
    Ob tem je Pahor dejal, da si je od začetka najave svoje kandidature za predsednika republike prizadeval pojasniti,
    kako pomembno je, da \"smo zlasti v tem času Slovenci, kolikor je le mogoče, povezani\"."
    
    {"text":
        ["Predsedstvo <a href=\"#party\">SD</a> je Boruta Pahorja potrdilo za kandidata stranke za predsednika države z le enim glasom proti .",
        "Ob tem je Pahor dejal , da si je od začetka najave svoje kandidature za predsednika republike prizadeval pojasniti , kako pomembno je , da \"smo zlasti v tem času Slovenci , kolikor je le mogoče , povezani\" ."],
     "entities":{
        "party":["SD"]
      }
    } 

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

For text tokenization use '/tokenize' method like so.
    
	curl http://politiki-si-ner.herokuapp.com/tokenize \
    -d "text=Zanima me če tokenizacija zares deluje?" 

	{"tokens":["Zanima","me","če","tokenizacija","zares","deluje","?"]}


## Some links

* [Politiki.si](http://politiki.si)
* [Apache OpenNLP](http://opennlp.apache.org/)
* [jRuby](http://jruby.org/)
* [Heroku jRuby Build Pack](https://github.com/carlhoerberg/heroku-buildpack-jruby)

## Contact me and/or give me job. ;)

Oto Brglez / [@otobrglez](http://opalab.com)