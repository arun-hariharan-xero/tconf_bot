require_relative "../web_scraper.rb"
require_relative "../bot_brains.rb"

describe 'Brains' do 
  context '#respond_bathroom' do 
    let(:brains) { BotBrains.new }
    it 'returns bathroom json'  do
      brains.process_schedule_data
      name = brains.fetch_ind_data("tconf what is Harini speaking about?")
      expect(name).to eql "Harini Rao"
    end
  end
end