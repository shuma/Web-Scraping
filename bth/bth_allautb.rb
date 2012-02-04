require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://edu.bth.se/utbildning/utb_sok_resultat.asp?lang=sv&KtTermin=20122&PtStartTermin=20122&vy=hitta"
doc = Nokogiri::HTML(open(url))
doc.xpath('//td/a/@href').each do |node|
  utblink = node.text
  puts "http://edu.bth.se/utbildning/#{utblink}"
  puts ""
end