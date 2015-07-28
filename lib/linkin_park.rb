require 'linkin_park/version'
require 'linkin_park/crawler'
require 'thor'

module LinkinPark
  class CLI < Thor
    desc "crawl https://gocardless.com", "Crawls the entire website and stores it locally"
    def crawl(url)
      crawler = Crawler.new
      crawler.crawl(url: url)
    end
  end
end
