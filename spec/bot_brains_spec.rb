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

  let(:brains) { BotBrains.new(@keywords) }
  let(:brains_double) { instance_double('BotBrains') }
  let(:message) {"one plus one"}

  context '#initialize' do 
    it 'initializes with correct objects' do 
      expect(brains.response).to_not be nil 
      expect(brains.keywords).to equal @keywords
    end
  end

  context '#bing_answer_for' do 
    it 'calls get_answer_from_bing() private method' do
      expect(brains).to receive(:get_answer_from_bing).with(message)
      brains.bing_answer_for(message)
    end
  end

  context '#get_speaker_hash' do 
    it 'calls process_speaker_data() private method' do 
      expect(brains).to receive(:process_speaker_data)
      brains.get_speaker_hash
    end

    it 'returns an Array' do 
      expect(brains.get_speaker_hash.class).to be Array
    end
  end

  context '#process_schedules' do
    it 'calls process_schedules() private method' do 
      expect(brains).to receive(:process_each_schedule)
      brains.process_schedules
    end
  end

  context '#get_location_faq' do 
    it 'calls process_faq_details() private method' do 
      expect(brains).to receive(:process_faq_details).with(message)
      brains.get_location_faq(message)
    end
  end
end