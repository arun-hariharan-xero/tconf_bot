require_relative 'Processors/message_processor'
require_relative 'Scraper/bot_brains'

require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'
require 'logger'

post '/gateway' do
  keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
  keywords = JSON.parse(keywords_json)
  brains = BotBrains.new(keywords)
  process_message = MessageProcessor.new(keywords, brains)

  logger = Logger.new(STDERR)
  logger.info(params)

  message = params[:text].gsub(params[:trigger_word], '').strip
  process_message.process(message)
  #Pry.start(binding)  
end

get '/' do
  "Hello World!!!"
end

  # keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
  # keywords = JSON.parse(keywords_json)
  # brains = BotBrains.new(keywords)
  # process_message = MessageProcessor.new(keywords, brains)

  # message = "are you still chigging along mate?"
  # process_message.process(message)