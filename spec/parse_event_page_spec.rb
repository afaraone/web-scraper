require 'parse_event_page'

describe ParseEventPage do
  # set up mock html file
  subject { described_class.new('./spec/mock-event-page.html') }

  describe '#return hash' do
    it 'returns a hash object with all details' do
      hash = { artist: 'BEN POOLE', date: 'WED 13TH FEB, 2019 7:00pm',
               location: 'OXFORD', venue: 'The Bullingdon', price: '£13.20' }
      expect(subject.return_hash).to eq(hash)
    end
  end
end
