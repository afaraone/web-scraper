# web-scraper

## Description
A CLI Web Scraper for extracting event information from https://wegottickets.com/ to a JSON string. Made as a tech test for SongKick.

## Tech Stack
- Ruby
- Pry, RSpec, Simplecov for testing
- Nokomuri for HTML parsing

## Instructions
- Run `bundle` to install dependencies
- Run `ruby run.rb` to see event JSON for the first page of WeGotTickets [Link](https://www.wegottickets.com/searchresults/page/1/all)


```

run.rb

require './lib/parse_event_index'

parser = ParseEventIndex.new('https://www.wegottickets.com/searchresults/page/1/all#paginate')
puts parser.return_json
```

```
ruby run.rb 
[{"date":"THU 14TH FEB, 2019 4:00pm","location":"WORTHING","venue":"ActivUs","artist":"VALENTINE'S DAY DISCO, FREE ROMANTIC MOVIE NO BABYSITTER NEEDED","price":"£9.50"},{"date":"THU 14TH FEB, 2019 5:00pm","location":"PRESTON","venue":"The Moorbrook","artist":"TINY REBEL 7TH BIRTHDAY BEER LAUNCH","price":"£23.10"},{"date":"THU 14TH FEB, 2019 6:00pm","location":"LONDON","venue":"The Islington","artist":"THE IRREGULARS","price":"£5.50"},{"date":"THU 14TH FEB, 2019 6:45pm","location":"LAVENHAM","venue":"Church","artist":"MOTOWN & PHILADELPHIA ON TOUR","price":"£28.89"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"LONDON","venue":"The Poodle Club","artist":"ADA CAMPE'S LOVE SHACK","price":"£7.70"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"NORTHAMPTON","venue":"Vintage Retreat","artist":"BAREFOOT IN THE PARK","price":"£9.90£8.80£7.70"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"ELY","venue":"Cinema","artist":"CASABLANCA (U) - DOOR 7PM FOR 7.30PM FILM","price":"£8.80£7.70£7.70£6.60"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"LONDON","venue":"Jamboree","artist":"CONCERT + DANCE CLASS: THE GOLDEN ERA OF JAZZ VALENTINES SPECIAL AT JAMBOREE","price":"£11.00"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"LONDON","venue":"New Cross Inn","artist":"DEAD GIRLS ACADEMY","price":"£11.00"},{"date":"THU 14TH FEB, 2019 7:00pm","location":"MEAVY","venue":"Parish Hall","artist":"GOATFINGER","price":"£9.90"}]

```

## Timing and Progress
Development took me 2 hours. By that point I have managed to make a web-scraper that can successfuly scrape one index page only.

## Testing
Testing was done using HTML fixtures, to prevent access to the actual website.
```
..

Finished in 0.00684 seconds (files took 0.21797 seconds to load)
2 examples, 0 failures

Coverage report generated for RSpec to /home/andres/projects/ruby/web-scraper/coverage. 56 / 56 LOC (100.0%) covered.
```

## Approach
My first step was to explore the website. I noticed several things which would dictate how this app would work.

Firstly, the event index pages have a limited number of events and there was no URL that displayed all of the events.
This means, that web scraper would need to make requests to all of the pages
```
https://www.wegottickets.com/searchresults/page/1/all
https://www.wegottickets.com/searchresults/page/2/all
https://www.wegottickets.com/searchresults/page/3/all
etc...
```

Secondly, the event index pages are missing prices.
This means that the web scraper would have to access individual event pages where all the information can be found.

The next step was to work out how to actually parse the HTML. I have actually played around with Nokomuri before and knew that I had to take note of the css selectors for the relevant event information.
This was achieved by using developer mode and selecting the elements I was looking for.

I decided that there would be two classes, one for parsing the events index page (`ParseEventIndex`) and one for the individual event page (`ParseEventPage`).

ParseEventPage is initialised with a url such as (`https://www.wegottickets.com/event/462464`). It uses private methods for extracting event information using Nokomuri's CSS selectors. In general, these were quite straightforward. The only one that required more thought was `location` and `venue`, since they are both on the same HTML element (e.g. `WORTHING: ActivUs`).
The only public method is `return_hash` which returns all the values for the purpose of creating a JSON string.

`ParseEventIndex` uses `ParseEventPage` as a dependency. It is initialised with an index url (https://www.wegottickets.com/searchresults/page/1/all
) for the purpose of extracting all of the URLs for individual event pages. `get_events` iterates through these URLs to instantiate a `ParseEventPage` object and map its hash value to an array.
The only public method is `return_json` which returns the array of event hashes as a JSON string.

## Reflection
I'm quite happy with my attempt. i think I have a fairly funtional web-scraper but there are several areas improvement or expansion.
 
 - Formatting
 
 For now all the values are stored as strings. However it would make more sense to save `price` and `date` as Floats and DateTime objects respectively. This would allow further functionality, e.g. returning all events on a certain day or above a certain price.
 
 - Price Issue
 
 I didn't originally realise that some of the product pages have mutliple prices (https://www.wegottickets.com/event/461443). In this app, the prices are concatenated to form a string. 
 ```
 {"date":"THU 14TH FEB, 2019 7:00pm","location":"ELY","venue":"Cinema","artist":"CASABLANCA (U) - DOOR 7PM FOR 7.30PM FILM","price":"£8.80£7.70£7.70£6.60"}
 ```
 A simple fix for this would have been selecting the first element of the array.
 
 
  - Extracting an Event class from ParseEventPage
  
  Right now, I feel that ParseEventPage is violating SRP, it is both extracting values from an HTML file and creating a hash object. It would make more sense to have it call an Event instance. This would allow for scalability for further behaviour concerning Event objects, e.g a link to the artists SongKick page.
  
  - Feature Test
  
  To do a feature test with fixtures, I knew that I would have had to make sure the index page would provide URL's for the individual event pages. I was worried about running out of time, so I ended up skipping this. This was probably my biggest regret.
  
  - Setting Edge Cases and Unhappy Paths
  
  - Extending the Web Scraper to parse all index pages
  
  This would've been relatively straightforward. I would have to make a loop with a counter that calls `ParseEventIndex` until it reaches the last page. Any URLs beyond the last page (e.g. https://www.wegottickets.com/searchresults/page/2000/all) have an empty `div.content` element. This would then trigger the loop to break.
