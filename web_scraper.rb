require_relative 'Dictionaries/keywords_list'
require_relative 'Process/process_message'
require_relative 'Scraper/bot_brains'

require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'
require 'logger'

post '/gateway' do
  keywords = Keywords.new
  brains = BotBrains.new
  process_message = ProcessMessage.new(keywords, brains)

  logger = Logger.new(STDERR)
  logger.info(params)

  message = params[:text].gsub(params[:trigger_word], '').strip
  process_message.process(message)
  #Pry.start(binding)  
end

# keywords = Keywords.new
# brains = BotBrains.new
# process_message = ProcessMessage.new(keywords, brains)

# message = "I love you"
# process_message.process(message)