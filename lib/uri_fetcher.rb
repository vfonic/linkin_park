require 'open-uri'

class UriFetcher
  def initialize(uri:, verbose: false)
    @uri = uri
    @verbose = verbose
    @fetched = false
  end

  def head
    fetch_webpage unless @fetched
    @head
  end

  def body
    fetch_webpage unless @fetched
    @body
  end

  alias_method :fetch, :body

  private

    def fetch_webpage
      # beware of OpenURI security issues!
      # http://sakurity.com/blog/2015/02/28/openuri.html
      puts "Fetching: #{@uri.to_s}" if @verbose
      begin
        response = open(@uri)
        @head = response.meta
        @body = response.read
        @fetched = true
      rescue OpenURI::HTTPError => e
        STDERR.puts e
      end
    end
end
