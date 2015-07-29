require 'nokogiri'
require 'uri_converter'
require 'uri_fetcher'
require 'file_storage'
require 'scraper'

module LinkinPark
  class Crawler
    def initialize(storage: nil, verbose: false)
      @verbose = verbose
      storage ||= FileStorage.new(verbose: @verbose)
      @storage = storage
      # here be stuff (options hash) like
      # recursive, domains, assets, robots, depth, etc
    end

    def crawl(url:)
      uri = UriConverter.new(uri: url)
      @visited_links = Set.new [ uri ]
      @queue = [ uri ]

      @root_url = uri.root_url

      crawl_from_queue
    end

    private
      def crawl_from_queue
        while uri = @queue.shift

          fetcher = UriFetcher.new(uri: uri, verbose: @verbose)
          body = fetcher.fetch
          next unless body

          path = uri.relative_path

          @storage.store(path: path, content: body)

          links = Scraper.links_for_page(http_response: fetcher)
          links.each do |link|
            begin
              uri = UriConverter.new(domain: @root_url, uri: link)

              unless @visited_links.include?(uri)
                @queue << uri
                @visited_links << uri
              end
            rescue URI::InvalidURIError => e
              STDERR.puts e
            end
          end

          puts "" if @verbose
        end
      end
  end
end
