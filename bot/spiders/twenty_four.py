from scrapy import Spider
from bot.items import NewsArticle
from bot.settings import POLITIKI_SETTINGS

class TwentyFourSpider(Spider):
    name = "twenty_four"
    allowed_domains = ["24ur.com"]
    start_urls = ["http://m.24ur.com/lbin/ajax_mobile_get_articles.php?page=%d&section=2" % page for page in xrange(1, POLITIKI_SETTINGS['spiders']['twenty_four']['limit'])]+\
                ["http://m.24ur.com/lbin/ajax_mobile_get_articles.php?page=%d&section=4" % page for page in xrange(1, POLITIKI_SETTINGS['spiders']['twenty_four']['limit'])]

    def parse(self, response):
        links = response.selector.xpath("//p/a/@href").extract()
        titles = [x.strip() for x in response.selector.xpath("//p/a/text()[normalize-space()]").extract()]
        for url, title in zip(links, titles):
            yield NewsArticle(url="http://m.24ur.com/%s" % url, title=title, site=self.name)
