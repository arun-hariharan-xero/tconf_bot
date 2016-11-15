require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'

post '/gateway' do
  all_speakers_list = ["speakers", "list", "of", "all"]
  message = params[:text].gsub(params[:trigger_word], '').strip
  
  if (message.split(' ') & all_speakers_list).any?
    respond_message get_speaker_hash
  else
    respond_message "Oops - you just asked a query that is being cooked into the bot-heart. Bad luck Brian!"
  end


  # This is an array - not needed for now
  # speaker_data = speakers.map.with_index { |e, i | e +", "+ speakers_title[i] }

  #Pry.start(binding)  
end

def respond_message message
    content_type :json
    {:text => message}.to_json
end

def get_speaker_hash
  # page = HTTParty.get('https://tconf.io', verify: false)
  # parse_page = Nokogiri::HTML(page)

  # speakers, speakers_title = [], []

  # parse_page.css('.speaker').css('.name').map do |name|
  #   speaker_name = name.text
  #   speakers << speaker_name
  # end

  # parse_page.css('.speaker').css('.text-alt').map do |title|
  #   speaker_title = title.text
  #   speakers_title << speaker_title
  # end

  # # Map speakers with their title and company as a hash
  # speaker_hash = Hash[speakers.zip(speakers_title)]
  "tessss"
end
