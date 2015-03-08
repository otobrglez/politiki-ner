from os import getenv

__author__ = 'otobrglez'
BOT_NAME = 'politik'
SPIDER_MODULES = ['bot.spiders']
NEWSPIDER_MODULE = 'bot.spiders'
USER_AGENT = 'Politik/0.1.0 (+http://politiki.si)'
POLITIKI_ENV = getenv("POLITIKI_ENV", "development")

POLITIKI_SETTINGS = {
    'development': {
        'log_level': 'DEBUG',
        'spiders': {
            'delo': {
                'limit': 30     # Number of pages per category
            },
            'finance': {
                'limit': 3      # Number of days ago
            },
            'twenty_four': {
                'limit': 100    # Number of pages per category
            }
        }
    }
}[POLITIKI_ENV]

ITEM_PIPELINES = {
    # 'collector.pipelines.BigQueryPipeline': 300,
    #'collector.pipelines.KPIPipeline': 300,
    #'collector.pipelines.ItemKPIPipeline': 400
}

DOWNLOAD_HANDLERS_BASE = {
    # 'file': 'scrapy.core.downloader.handlers.file.FileDownloadHandler',
    # 'http': 'scrapy.core.downloader.handlers.http.HttpDownloadHandler',
    'http': 'scrapy.core.downloader.handlers.http10.HTTP10DownloadHandler',
    'https': 'scrapy.core.downloader.handlers.http10.HTTP10DownloadHandler',
    #'http': 'scrapy_webdriver.download.WebdriverDownloadHandler',
    #'https': 'scrapy_webdriver.download.WebdriverDownloadHandler',
}

#SPIDER_MIDDLEWARES = {
#    'scrapy_webdriver.middlewares.WebdriverSpiderMiddleware': 543,
#}

#WEBDRIVER_BROWSER = 'PhantomJS'  # Or any other from selenium.webdriver
                                 # or 'your_package.CustomWebdriverClass'
                                 # or an actual class instead of a string.
# Optional passing of parameters to the webdriver
#WEBDRIVER_OPTIONS = {
#    'service_args': ['--debug=true', '--load-images=false', '--webdriver-loglevel=debug']
#}

EXTENSIONS = {
    # 'extensions.notifications.WebHookNotification': 300
}

# Available - CRITICAL, ERROR, WARNING, INFO, DEBUG
LOG_LEVEL = POLITIKI_SETTINGS['log_level']
