require 'nokogiri'
require 'open-uri'
require_relative 'parse_event_page.rb'
require 'json'

# This class is responsible for scraping the index pages on wegottickets
# Its public method is return_json which returns a
# JSON string of all events on that page
class ParseEventIndex
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
    @event_array = get_event_hashes(extract_event_urls)
  end

  # Returns event array as a JSON string
  def return_json
    @event_array.to_json
  end

  private

  # Iterates through event urls, instantiates an Event Page Parser
  # and maps it hash to an array
  def get_event_hashes(url_array)
    url_array.map do |event_url|
      ParseEventPage.new(event_url).return_hash
    end
  end

  # Collects all urls for individual event pages on index page
  def extract_event_urls
    @html.css('.event_link').map { |anchor| anchor['href'] }
  end
end
