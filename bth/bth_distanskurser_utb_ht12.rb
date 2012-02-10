require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Hämtar distanskurser HT-2012
url = "http://edu.bth.se/utbildning/utb_sok_resultat.asp?lang=sv&KtUtbildningsForm=DST&KtUtbildningsForm=ITD&KtTermin=inne&KtTermin=nast&KtTyp=FRIS&KtTyp=SOMM&KtTyp=PROG&Rubrik=Distanskurser
"
doc = Nokogiri::HTML(open(url))
doc.xpath('//td/a/@href').each do |node|
  utblink = node.text
  puts "http://edu.bth.se/utbildning/#{utblink}"
  puts ""
end
