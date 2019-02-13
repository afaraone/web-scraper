require 'nokogiri'
require 'open-uri'

class ParseEventPage
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
    @date = extract_date
    @location, @venue = extract_location_and_venue
    @artist = extract_artist
    @price = extract_price
  end

  def return_hash
    {
      date: @date,
      location: @location,
      venue: @venue,
      artist: @artist,
      price: @price
    }
  end

  private
  def extract_date
    @html.css('.venue-details h4').text
  end

  def extract_artist
    @html.css('.event-information h1').text
  end

  def extract_location_and_venue
    @html.css('.venue-details h2').text.split(': ')
  end

  def extract_price
    @html.css('.text-right strong').text
  end
end
