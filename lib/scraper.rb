require 'nokogiri'

class Scraper
  HTML_LINK_ELEMENT_ATTRIBUTES = [
    [ "a", "href" ],
    [ "img", "src" ],
    [ "script", "src" ],
    [ "link", "href "]
  ]

  def self.links_for_page(http_response:)
    links = []
    return links unless http_response.head["content-type"] =~ %r{text/html}

    html = Nokogiri::HTML(http_response.body)

    HTML_LINK_ELEMENT_ATTRIBUTES.each do |element, attribute|
      links += links_for(html: html, element: element, attribute: attribute)
    end

    links
  end

  def self.links_for(html:, element:, attribute:)
    links = []

    html.css(element).each do |link|
      if href = link.attr(attribute)
        next if should_refuse_url?(url: href)

        links << href
      end
    end

    links
  end

  private
    def self.should_refuse_url?(url:)
      url.empty? || url.start_with?('//') || url.start_with?('http://') || url.start_with?('https://') || url.start_with?('#')
    end
end
