require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'httparty'

page = HTTParty.get('https://tconf.io', verify: false)
parse_page = Nokogiri::HTML(page)

speakers, speakers_title = [], []

parse_page.css('.speaker').css('.name').map do |name|
  speaker_name = name.text
  speakers << speaker_name
end

parse_page.css('.speaker').css('.text-alt').map do |title|
  speaker_title = title.text
  speakers_title << speaker_title
end

# Map speakers with their title and company as a hash
speaker_hash = Hash[speakers.zip(speakers_title)]


# This is an array - not needed for now
# speaker_data = speakers.map.with_index { |e, i | e +", "+ speakers_title[i] }

#Pry.start(binding)