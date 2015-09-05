require 'nokogiri'
require 'open-uri'
require 'csv'


brand_details = {}

urls = []

CSV.foreach('../brands.csv') do |row|
  urls << row[1]
end

urls[0..100].each do |url|
  doc = Nokogiri::HTML(open(url))
  name = doc.css('h1').text
  item_number = doc.css('div.productInfo > h3').text.gsub("Item #", '').to_i
  size = doc.css('div.productInfo > ul > li' )[0].text.gsub("Size: ", '')
  type = doc.css('div.productInfo > ul > li' )[1].text.gsub("Type: ",'')
  # country = doc.css('div.productInfo > ul > li' )[2].text.gsub("Country: ", '')
  # proof = doc.css('div.productInfo > ul > li' )[4].text.gsub("Proof: ", '').to_i

  brand_details[name] = [url, item_number, size, type]
  # sleep 1
end

CSV.open("brand_details.csv", "a") {|csv| brand_details.to_a.each {|elem| csv << elem }}