require 'open-uri'
require 'nokogiri'
require 'fileutils'

module LinkinPark
  class Crawler
    def initialize
      # here be stuff (options hash) like
      # recursive, domains, assets, robots, depth, etc
      @visited_links = Set.new [ "" ]
      @queue = []
    end

    def crawl(url:)
      uri = URI(url)
      setup(uri: uri)

      @queue << uri

      until @queue.empty?
        uri = @queue.shift

        body = fetch_body(uri:uri)

        file_relative_path = file_name(uri: uri)

        write_to_file(content: body, path: file_relative_path)

        add_links_to_queue(body)
        puts ""
      end
    end

    private
      def setup(uri:)
        @root_url = "#{uri.scheme}://#{uri.host}"
        domain = uri.host
        @base_path = File.join(Dir.pwd, domain)
        FileUtils.mkdir_p(@base_path)
        @visited_links << uri
      end

      def fetch_body(uri:)
        puts "Fetching: #{uri.to_s}"
        page = open(uri)
        page.read
      end

      def file_name(uri:)
        path = uri.path
        path = File.join(path, "index.html") if File.extname(path) == '' || path.end_with?('/')
        File.join(@base_path, path)
      end

      def write_to_file(content:, path:)
        puts "Saving to: #{path}"

        dirname = File.dirname(path)

        FileUtils.mkdir_p(dirname)

        open(path, "wb") do |file|
          file.write(content)
        end
      end

      def add_links_to_queue(body)
        html = Nokogiri::HTML(body)
        html.css("a").each do |link|
          if href = link.attr("href")
            next if should_refuse_url?(url: href)

            uri = URI::join(@root_url, href)

            unless @visited_links.include?(uri)
              @queue << uri
              @visited_links << uri
            end
          end
        end
      end

      def should_refuse_url?(url:)
        url.empty? || url.start_with?('http://') || url.start_with?('https://') || url.start_with?('#')
      end
  end
end
