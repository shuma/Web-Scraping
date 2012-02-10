require 'rubygems'
require 'nokogiri'
require 'open-uri'

# parse the HTML document with all the links to the XML files.
doc = Nokogiri::HTML(open('http://testnavet.skolverket.se/SusaNavExport/EmilExporter?GetEvent&EMILVersion=1.1&NotExpired&EIAcademicType=UoH&SelectEP'))
# URLS - array
@urls = Array.new 
#Get all XML-urls and save them in urls-array
doc.xpath('//a/@href').each do |links|
  @urls << links.content
end

#LOCALITY array
@locality = Array.new
# loop all the url of the XML files
@urls.each do |url|
  doc = Nokogiri::HTML(open(url))
  # grab the content I want
  doc.xpath('//educationprovider//vcard//org/orgname').each do |locality_node| 
   # store it in locality array
    @locality << locality_node.content
  end
end

# loop the the locality array and print it out
(0..@locality.length - 1).each do |index|
  puts "Namn: #{@locality[index]}"
end
puts "Antal högskolor: #{@locality.length}"








