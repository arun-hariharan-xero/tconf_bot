require_relative "../web_scraper"
require_relative "../Scraper/bot_brains"
require_relative "../Processors/fetchers"
require_relative "../Processors/message_processor"
require_relative '../Response/responses'
require_relative '../Processors/fetchers'
require_relative '../Dictionaries/keywords_list'

describe 'BotBrains' do 
  before do 
    keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
    @keywords = JSON.parse(keywords_json)
  end 

  context '#fetch_love' do 
    let(:brains) { BotBrains.new(@keywords) }

    it 'processes the msessage correctly' do 
      brains.bing_answer_for("HTC 10?")
    end
  end
end