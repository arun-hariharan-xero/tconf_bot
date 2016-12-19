require_relative 'Scraper/bot_brains'
require_relative 'Process/process_message'

require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'

post '/gateway' do
  brains = BotBrains.new
  puts params
  message = params[:text].gsub(params[:trigger_word], '').strip
  ProcessMessage.process(message, brains)
  #Pry.start(binding)  
end