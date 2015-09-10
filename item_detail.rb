require 'nokogiri'
require 'open-uri'
require 'csv'


brand_details = {}

urls = []

CSV.foreach('../brands.csv') do |row|
  urls << row[1]
end

urls[0..-1].each do |url|
  doc = Nokogiri::HTML(open(url))
  name = doc.css('h1').text
  item_number = doc.css('div.productInfo > h3').text.gsub("Item #", '').to_i
  doc.css('div.productInfo > ul > li' )[0] != nil ? size = doc.css('div.productInfo > ul > li' )[0].text.gsub("Size: ", '') : size = nil
  doc.css('div.productInfo > ul > li' )[1] != nil ? type = doc.css('div.productInfo > ul > li' )[1].text.gsub("Type: ",'') : type = nil

  brand_details[name] = [url, item_number, size, type]
  sleep 1
end

CSV.open("brand_details.csv", "a") {|csv| brand_details.to_a.each {|elem| csv << elem }}