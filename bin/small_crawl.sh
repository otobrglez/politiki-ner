#!/usr/bin/env bash

spiders=(twenty_four finance delo)

for i in ${spiders[*]}; do
  printf "Scheduling spider: %s\n" $i
  scrapy crawl $i -o data/urls/$i.csv -t csv -O --nolog
done
