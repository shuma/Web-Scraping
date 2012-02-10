require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Hämtar kurser HT-2012
url = "http://edu.bth.se/utbildning/utb_sok_resultat.asp?KtUtbildningsForm=NML&KtKurstid=DAG&KtKurstid=KV%C4&KtTermin=nast&KtOrt=1080&KtOrt=1081&KtOrt=1082&KtTakt=25&KtTakt=50&KtTakt=100&KNivaIndelning=GYMN&KNivaIndelning=GRUN&KNivaIndelning=ADVN&PtUtbildningsForm=NML&PtKursTid=DAG&PtKursTid=KV%C4&PtStartTermin=nast&PtOrt=1080&PtOrt=1081&PtOrt=1082&PtLinFart=25&PtLinFart=50&PtLinFart=100&PrNivaIndelning=GYMN&PrNivaIndelning=GRUN&PrNivaIndelning=ADVN&KtTyp=FRIS&lang=sv"
doc = Nokogiri::HTML(open(url))
doc.xpath('//td/a/@href').each do |node|
  utblink = node.text
  puts "http://edu.bth.se/utbildning/#{utblink}"
  puts ""
end
