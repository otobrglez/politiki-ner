from scrapy import Spider
from re import match
from bot.items import NewsArticle
from bot.settings import POLITIKI_SETTINGS

class DeloSpider(Spider):
    name = "delo"
    allowed_domains = ["delo.si"]
    start_urls = ["http://m.delo.si/novice/page/%d" % page for page in xrange(1, POLITIKI_SETTINGS['spiders']['delo']['limit'])]+\
                 ["http://m.delo.si/gospodarstvo/page/%d" % page for page in xrange(1, POLITIKI_SETTINGS['spiders']['delo']['limit'])]

    def parse(self, response):
        links = response.selector.xpath("//div[@class='article_box']//a/@href").extract()
        titles = [x.strip() for x in response.selector.xpath("//div[@class='article_box']//a/text()[normalize-space()]").extract()]
        for url, title in [x for x in zip(links, titles) if match(".+(slovenija|politika|gospodarstvo).+", x[0])]:
            yield NewsArticle(url="http://www.delo.si%s" % url, title=title, site=self.name)
