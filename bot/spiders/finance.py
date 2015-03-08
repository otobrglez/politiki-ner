from scrapy import Spider
from re import match
from bot.items import NewsArticle
import datetime
from bot.settings import POLITIKI_SETTINGS

class FinanceSpider(Spider):
    name = "finance"
    allowed_domains = ["www.finance.si"]
    start_urls = ["http://www.finance.si/danes?op=danes&date=%s" % date for date in [
        (datetime.date.today() - datetime.timedelta(days=x)).strftime("%d.%m.%Y") for x in xrange(0, POLITIKI_SETTINGS['spiders']['finance']['limit'])]
    ]

    def parse(self, response):
        links = response.selector.xpath("//div[@class='headline']/a[@class='title sub']/@href").extract()
        titles = response.selector.xpath("//div[@class='headline']/a[@class='title sub']/@title").extract()
        for url, title in [x for x in zip(links, titles) if match("http://www\.finance", x[0])]:
            yield NewsArticle(url=url, title=title, site=self.name)
