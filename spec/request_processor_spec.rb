require_relative "../Scraper/bot_brains"
require_relative '../Response/responses'


describe 'RequestProcessor' do 
  before do 
    keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
    @keywords = JSON.parse(keywords_json)
  end 

  context '#fetch_love' do 
    let(:brains) { BotBrains.new(@keywords) }
    let(:response) { Responses.new }
    let(:request) { RequestProcessor.new(@keywords, brains, response) }

    it 'processes the msessage correctly' do 
      request.bingo("one plus one")
    end
  end
end