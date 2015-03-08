#!/usr/bin/env python

# http://www.clips.ua.ac.be/pages/pattern-web
# http://stackoverflow.com/questions/328356/extracting-text-from-html-file-using-python
# http://www.slideshare.net/japerk/nltk-in-20-minutes

from sys import argv, stderr
from bs4 import BeautifulSoup
from urllib import urlopen

if len(argv) < 1:
    print >> stderr, "Missing URL!"
    exit(1)

url = argv[1].strip()

html = urlopen(url).read()
soup = BeautifulSoup(html)

for script in soup(["script", "style", "header", "footer", "sidebar"]):
    script.extract()    # rip it out

text = soup.get_text()

# break into lines and remove leading and trailing space on each
lines = (line.strip() for line in text.splitlines())
# break multi-headlines into a line each
chunks = (phrase.strip() for line in lines for phrase in line.split("  "))
# drop blank lines
text = '\n'.join(chunk for chunk in chunks if chunk)

print(text)
