require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Hämtar distansprogram HT-2012
url = "http://edu.bth.se/utbildning/utb_sok_resultat.asp?lang=sv&PtUtbildningsForm=DST&PtUtbildningsForm=ITD&PtStartTermin=20122&PtStartTermin=20121&Program=JA&Rubrik=Distansprogram"
doc = Nokogiri::HTML(open(url))
doc.xpath('//td/a/@href').each do |node|
  utblink = node.text
  puts "http://edu.bth.se/utbildning/#{utblink}"
  puts ""
end
