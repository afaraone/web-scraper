require 'parse_event_page'

describe ParseEventPage do
  #set up mock html file 
  subject { described_class.new('./spec/mock-event-page.html') }

  describe '#extract_date' do
    it 'returns date from html' do
      expect(subject.extract_date).to eq('WED 13TH FEB, 2019 7:00pm')
    end
  end

  describe '#extract_artist' do
    it 'returns artist from html' do
      expect(subject.extract_artist).to eq('BEN POOLE')
    end
  end
end
