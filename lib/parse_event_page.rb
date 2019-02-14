require 'nokogiri'
require 'open-uri'

# This class is responsible for parsing individual event pages
# Its public method is return_hash, which returns all event details as a hash
class ParseEventPage
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
    @date = extract_date
    @location, @venue = extract_location_and_venue
    @artist = extract_artist
    @price = extract_price
  end

  # return event details as a hash
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

  # These methods are all extractions using Nokogiri CSS selector methods
  def extract_date
    @html.css('.venue-details h4').text
  end

  def extract_artist
    @html.css('.event-information h1').text
  end

  # Location and venue are under the same h2 element, so they are split by ': '
  def extract_location_and_venue
    @html.css('.venue-details h2').text.split(': ')
  end

  def extract_price
    @html.css('.text-right strong').text
  end
end
