# Politiki NER

Named-entity recognition project for Slovenian political data.

## Installation & development

    # Python 2.7.6
    mkvirtualenv --no-site-packages politiki
    workon politiki
    pip install --upgrade -r requirements.txt

## Libaries and tools used

- [Python NTLK](http://www.nltk.org/)
- [IPython](http://ipython.org/)
- [Aria2](https://wiki.archlinux.org/index.php/aria2)

## Preparing and scraping data

Manually scrape each portal or run './bin/small_crawl.sh' script

    scrapy crawl delo -o data/urls/delo.csv -t csv -O --nolog

Combine URL lists into one huge list.

    cat data/urls/*.csv | cut -d ',' -f1 | grep -v -e "url" | uniq -u > data/lists/big.txt

Use Aria2 to download everything for offline processing

    aria2c --conf-path aria_config -i data/lists/big.txt


## Author and credit

- [Oto Brglez](https://github.com/otobrglez)

