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

  # keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
  # keywords = JSON.parse(keywords_json)
  # brains = BotBrains.new(keywords)
  # process_message = MessageProcessor.new(keywords, brains)

  # message = "I love you"
  # process_message.process(message)