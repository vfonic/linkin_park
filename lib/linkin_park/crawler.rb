require 'open-uri'
require 'nokogiri'
require 'fileutils'
require 'linkin_park/uri_converter'

module LinkinPark
  class Crawler
    def initialize
      # here be stuff (options hash) like
      # recursive, domains, assets, robots, depth, etc
    end

    def crawl(url:)
      uri = UriConverter.new(uri: url)
      @visited_links = Set.new [ uri ]
      @queue = [ uri ]

      @root_url = uri.root_url

      until @queue.empty?
        uri = @queue.shift

        body = fetch_body(uri: uri.to_s)
        next unless body

        path = uri.file_relative_path

        write_to_file(content: body, path: path)

        add_links_to_queue(body)
        puts ""
      end
    end

    private
      def fetch_body(uri:)
        puts "Fetching: #{uri.to_s}"
        begin
          page = open(uri)
          page.read
        rescue OpenURI::HTTPError => e
          STDERR.puts e
        end
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
        links_for(html: html, element: "a", attribute: "href")
        links_for(html: html, element: "img", attribute: "src")
        links_for(html: html, element: "script", attribute: "src")
        links_for(html: html, element: "link", attribute: "href")
      end

      def links_for(html:, element:, attribute:)
        html.css(element).each do |link|
          if href = link.attr(attribute)
            href = href.slice(0, href.index('#')) if href.index('#')
            next if should_refuse_url?(url: href)

            begin
              uri = UriConverter.new(domain: @root_url, uri: href)
            rescue URI::InvalidURIError => e
              STDERR.puts e
              next
            end

            unless @visited_links.include?(uri)
              @queue << uri
              @visited_links << uri
            end
          end
        end
      end

      def should_refuse_url?(url:)
        url.empty? || url.start_with?('//') || url.start_with?('http://') || url.start_with?('https://') || url.start_with?('#')
      end
  end
end
