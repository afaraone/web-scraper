require 'parse_event_index'

describe ParseEventIndex do
  subject { described_class.new('./spec/mock-events-index.html') }
  describe '#return_json' do
    before do
      mock_event_instance = double
      mock_hash = { artist: 'Artist', venue: 'Venue' }
      mock_hash_collection = [mock_hash, mock_hash, mock_hash]
      allow(ParseEventPage).to receive(:new).and_return(mock_event_instance)
      allow(mock_event_instance).to receive(:return_hash).and_return(mock_hash)
    end

    it 'returns array of event hashes as JSON string' do
      mock_hash = { artist: 'Artist', venue: 'Venue' }
      json = [mock_hash, mock_hash, mock_hash].to_json
      subject.return_json
    end
  end
end
