require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.edu.mah.se/katalog/H2012/program/grund"
doc = Nokogiri::HTML(open(url))

doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "frontpage-content", " " ))]//a/@href').each do |node|
  puts node.text
  puts ""
end