require 'parse_event_index'

describe ParseEventIndex do
  subject { described_class.new('./spec/mock-events-index.html')}
  describe '#extract_event_urls' do
    it 'returns array of urls for individual event pages' do
      urls = ["https://www.wegottickets.com/event/1", "https://www.wegottickets.com/event/2", "https://www.wegottickets.com/event/3"]
      expect(subject.extract_event_urls).to eq(urls)
    end
  end

  describe '#get_event_hash' do
    before do
      mockEventInstance = double()
      mock_hash = {artist: "Artist", venue: "Venue"}
      mock_hash_collection = [mock_hash, mock_hash, mock_hash]
      allow(ParseEventPage).to receive(:new).and_return(mockEventInstance)
      allow(mockEventInstance).to receive(:return_hash).and_return(mock_hash) 
    end

    it 'instantiates ParseEventPage for each url (in this case 3) and returns array of ParseEventPage#return_hash' do
      mock_hash = {artist: "Artist", venue: "Venue"}
      mock_hash_collection = [mock_hash, mock_hash, mock_hash]
      urls = subject.extract_event_urls
      expect(subject.get_event_hashes(urls)).to eq(mock_hash_collection)
    end
  end
end
