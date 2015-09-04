require 'nokogiri'
require 'open-uri'
require 'csv'

#script for scraping brand names and links from a large retailer

#if pagination is used
page_range = (1..171)

#container hash
brands = {}

#gathering the data
page_range.each do |page|
  # dummy data for urls
  url = "?????????????/#{page}"
  doc = Nokogiri::HTML(open(url))

  # the following will depend on how the page is structured
  # here getting the 'a' tag under each h3 tag

  entries = doc.css('h3 > a')

  #turing the brand name into a key and the retailer url into a value
  entries.each {|e| brands[e.text] = "?????????" + e['href']}
end


#writing to a CSV
CSV.open("brands.csv", "wb") {|csv| brands.to_a.each {|elem| csv << elem }}