require_relative "../web_scraper.rb"
require_relative "../Scraper/bot_brains.rb"
require_relative "../Processors/fetchers.rb"

# describe 'Brains' do 
#   context '#respond_bathroom' do 
    
#     let(:brains) { BotBrains.new }
#     let(:message) { 'what is one plus one' }

#     it 'returns answer from bing' do
#       bing_result = instance_double('BotBrains')
#       expect(bing_result).to receive(:get_answer_from_bing)
#       #bing_result.get_answer_from_bing(message)
#       bing_result.bingo(message)
#     end
#   end
# end

describe 'Fetchers' do 
  before do 
    keywords_json = File.read(File.expand_path("./Dictionaries/keywords_prebuilt.json"))
    @keywords = JSON.parse(keywords_json)
  end 
  context '#fetch_love' do 
    let(:brains) {BotBrains.new(@keywords)}
    let(:fetch) { Fetchers.new(@keywords, brains) }

    it 'returns some love quotes' do 
      fetch.fetch_love
    end
    it 'returns questions' do 
      fetch.fetch_question
    end
    it 'returns snap' do 
      fetch.fetch_snap
    end
    it 'returns compliments' do 
      fetch.fetch_compliment
    end
    it 'returns lol' do 
      fetch.fetch_lol
    end
    it 'returns wishes' do 
      fetch.fetch_wishes
    end
    it 'returns jokes' do 
      fetch.fetch_jokes
    end
    it 'returns faq answer' do 
      fetch.fetch_faq_answer('bathroom')
    end
  end
end