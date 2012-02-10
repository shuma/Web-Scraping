require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

#Hämtar alla länkar till uni/hog
doc = Nokogiri::HTML(open('http://testnavet.skolverket.se/SusaNavExport/EmilExporter?GetEvent&EMILVersion=1.1&NotExpired&EIAcademicType=UoH&SelectEP'))
# URLS - array för att lagrar alla länkar
@urls = Array.new 
# Hämtar alla länkar för xml-filerna och sparar dom i arrayn urls
doc.xpath('//a/@href').each do |links|
  @urls << links.content
end

#LOCALITY
@ort        = Array.new
#ORGNAME
@namn       = Array.new
#PCODE
@postadress = Array.new
#NUMBER
@tfn        = Array.new
#USER-ID
@epost      = Array.new
#URL
@webbadress = Array.new

#Loopar igenom alla XML-filer-länkar och parsar efter spec taggar
@urls.each do |url|
  doc = Nokogiri::HTML(open(url))
  #Hämtar alla ort
  doc.xpath('//educationprovider//vcard//adr/locality').each do |ort_node| 
    @ort << ort_node.content
  end
  #Hämta alla uni/hog namn
  doc.xpath('//educationprovider//vcard//org/orgname').each do |namn_node|
    @namn << namn_node.content
  end
  #Hämtar alla postadress
  doc.xpath('//educationprovider//vcard//adr/pcode').each do |postadress_node|
    @postadress << postadress_node.content
  end
  #Hämtar alla tfn
  doc.xpath('//educationprovider//vcard//tel/number').each do |tfn_node|
    @tfn << tfn_node.content
  end
  #Hämtar alla epost
  doc.xpath('//educationprovider//vcard//email/userid').each do |epost_node|
    @epost << epost_node.content
  end
  #Hämtar alla webbadress
  doc.xpath('//educationprovider//vcard//url').each do |webbadress_node|
    @webbadress << webbadress_node.content
  end
  # Lagrar dom i uni.CSV
  CSV.open("uni.csv", "wb") do |row|
    row <<["namn", "postadress", "tfn", "epost", "webbadress"]
    (0..@namn.length - 1).each do |index|
      row << [@namn[index], @postadress[index], @tfn[index], @epost[index], @webbadress[index]]
    end
  end
end
#Skriver ut.
(0..@namn.length - 1).each do |index|
  puts "Namn: #{@namn[index]}"
  puts "Ort: #{@ort[index]}"
  puts "Postadress: #{@postadress[index]}"
  puts "Tfn: #{@tfn[index]}"
  puts "Epost: #{@epost[index]}"
  puts "Webbadress: #{@webbadress[index]}"
  puts ""
end
  puts "Antal högskolor: #{@namn.length}"
