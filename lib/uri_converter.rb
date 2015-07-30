class UriConverter
  attr_accessor :uri
  include Comparable

  def initialize(domain: nil, uri:)
    url = strip_parameters_and_fragment(uri)
    if domain
      @uri = URI::join(domain, url)
      raise CrossDomainError, "#{@uri.to_s} doesn't belong under #{domain} domain." unless @uri.to_s.start_with?(domain)
    else
      @uri = URI.parse(url)
      unless @uri.kind_of?(URI::HTTP) || @uri.kind_of?(URI::HTTPS)
        @uri = "http://#{@uri}"
        raise InvalidUriError, @uri.to_s unless @uri.kind_of?(URI::HTTP) || @uri.kind_of?(URI::HTTPS)
      end
      @uri = URI(url)
    end
  end

  def relative_path
    base_path = File.join(Dir.pwd, @uri.host)
    path = @uri.path
    path = File.join(path, "index.html") if File.extname(path) == '' || path.end_with?('/')
    File.join(base_path, path)
  end

  def root_url
    "#{@uri.scheme}://#{@uri.host}"
  end

  def to_s
    @uri.to_s
  end

  def to_str
    to_s
  end

  def <=>(other)
    @uri <=> other.uri
  end

  def eql?(other_key)
    @uri == other_key.uri
  end

  def hash
    @uri.hash
  end

  private
    def strip_parameters_and_fragment(url)
      url = url.slice(0, url.index('?')) if url.index('?')
      url = url.slice(0, url.index('#')) if url.index('#')
      url
    end
end

class InvalidUriError < StandardError; end

class CrossDomainError < StandardError; end
