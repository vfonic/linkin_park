module LinkinPark
  class Crawler
    def initialize
      # here be stuff (options hash) like
      # recursive, domains, assets, robots, depth, etc
    end

    def crawl(url)
      crawler = Crawler.new
      crawler.crawl(url: url)
    end
  end
end
