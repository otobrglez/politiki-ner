from scrapy.item import Item, Field
from datetime import datetime

class NewsArticle(Item):
    site = Field()
    url = Field()
    title = Field()

    fields_to_export = ["url"]