require 'nokogiri'
require 'open-uri'
require_relative 'parse_event_page.rb'

class ParseEventIndex
  attr_reader :html

  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def get_event_hashes(url_array)
    url_array.map do |event_url|
      ParseEventPage.new(event_url).return_hash
    end
  end

  def extract_event_urls
    @html.css('.event_link').map { |anchor| anchor['href'] }
  end
end
