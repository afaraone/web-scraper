require './lib/parse_event_index'

parser = ParseEventIndex.new('https://www.wegottickets.com/searchresults/page/1/all#paginate')
puts parser.return_json
