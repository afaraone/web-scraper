require 'nokogiri'
require 'open-uri'

class ParseEventPage
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def extract_date
    @html.css('.venue-details h4').text
  end
end
