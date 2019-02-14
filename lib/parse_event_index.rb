require 'nokogiri'
require 'open-uri'
require_relative 'parse_event_page.rb'
require 'json'

class ParseEventIndex
  def initialize(url)
    @html = Nokogiri::HTML(open(url))
    @event_array = get_event_hashes(extract_event_urls)
  end

  def return_json
    @event_array.to_json
  end

  private

  def get_event_hashes(url_array)
    url_array.map do |event_url|
      ParseEventPage.new(event_url).return_hash
    end
  end

  def extract_event_urls
    @html.css('.event_link').map { |anchor| anchor['href'] }
  end
end
