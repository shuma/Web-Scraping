# Extra note: "<<" is an binary left shift operator. The left operands value is moved left by the number of bits specified by the right operand.  
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

urls = Array[
  'http://www.industrialfansdirect.com/IND-FA-AF-S.html',
  'http://www.industrialfansdirect.com/IND-FA-AF-WE.html',
  'http://www.industrialfansdirect.com/IND-FA-AF-SS.html',
  'http://www.industrialfansdirect.com/IND-FA-AF-CF.html',
  'http://www.industrialfansdirect.com/IND-FA-BL.html',
  'http://www.industrialfansdirect.com/IND-FI-CF.html'
]

@prices         = Array.new
@serial_numbers = Array.new
@descriptions   = Array.new

urls.each do |url|
  doc = Nokogiri::HTML(open(url))
  # Hämtar prisinformationen & lagrar i array prices
  doc.css('div > b > font').each do |price|
    @prices << price.content
  end

  # Hämtar serialnummer & lagar i arrayn serial_numbers
  doc.css('div#contentalt1 table + table div:first-child b').each do |serial_number|
    @serial_numbers << serial_number.content
  end

  #Hämtar produkt-beskrivning & lagar i arrayn descriptions
  doc.css('div#contentalt1 table + table tr + tr td a').each do |description|
    @descriptions << description.content unless description.content.length < 2
  end

  (0..@prices.length - 1).each do |index|
    puts "Serial number: #{@serial_numbers[index]}"
    puts "Price: #{@prices[index]}"
    puts "Description: #{@descriptions[index]}"
    puts ""
  end
end
CSV.open("fans.csv", "wb") do |row|
  (0..@prices.length - 1).each do |index|
    row << [@serial_numbers[index], @prices[index], @descriptions[index]]
  end
end
  
  