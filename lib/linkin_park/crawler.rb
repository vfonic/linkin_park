require 'open-uri'

module LinkinPark
  class Crawler
    def initialize
      # here be stuff (options hash) like
      # recursive, domains, assets, robots, depth, etc
      @visited_links = {}
      @queue = []
    end

    def crawl(url:)
      @queue << url

      until @queue.empty?
        url = @queue.shift
        open("sample.html", "wb") do |file|
          open(url, "rb") do |page|
            file.write(page.read)
          end
        end
      end
    end
  end
end
