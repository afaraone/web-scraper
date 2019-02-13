require 'nokogiri'
require 'open-uri'

class ParseEventPage
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def extract_date
    @html.css('.venue-details h4').text
  end

  def extract_artist
    @html.css('.event-information h1').text
  end

  def extract_location_and_venue
    @html.css('.venue-details h2').text.split(': ')
  end
end
