require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://edu.bth.se/utbildning/utb_program.asp?PtKod=FMAFP12h&lang=sv"
doc = Nokogiri::HTML(open(url))
#Hämtar utb namn
doc.xpath('//*[(@id = "utb_programtitel")]').each do |name|
  puts name.content
end

#Hämtar utb-beskrivning
doc.xpath('//h2[(((count(preceding-sibling::*) + 1) = 8) and parent::*)]//br').each do |beskrivning|
  puts beskrivning.content
end