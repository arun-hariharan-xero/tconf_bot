require 'json'
require 'pp'
require_relative '../Scraper/bot_brains'

class Fetchers

  attr_reader :keywords, :brains

  def initialize(keywords, brains)
    @brains = brains
    @keywords = keywords
  end

  define_method(:fetch_compliment) { keywords["responses"]["compliment"].values.sample }

  define_method(:fetch_love) { keywords["responses"]["fetch_love"].values.sample }
  
  define_method(:fetch_question) { keywords["responses"]["fetch_question"].values.sample }
  
  define_method(:fetch_snap) { keywords["responses"]["fetch_snap"].values.sample }

  define_method(:fetch_lol) { keywords["responses"]["fetch_lol"].values.sample }

  define_method(:fetch_wishes) { keywords["responses"]["fetch_wishes"].values.sample }
  
  define_method(:fetch_jokes) { ["From the land of botnet", keywords["responses"]["fetch_jokes"].values.sample] }

  def fetch_ind_data(message)
    full_name = ""
    message.split(' ').each_with_index do |msg, ind|
      if (keywords['lists']['individual_list_1'].include? msg.capitalize) 
        new_ind = keywords['lists']['individual_list_1'].index(msg)
        full_name = brains.names[new_ind]
      elsif (keywords['lists']['individual_list'].include? msg.capitalize) 
        new_ind = keywords['lists']['individual_list'].index(msg)
        full_name = brains.names[new_ind]
      end
    end
    full_name
  end

  def fetch_detailed_speaker_info(full_name)
    full_speaker_data = []
    brains.individual_speech.each do |key, value|
      if key == full_name
        full_speaker_data << key
        full_speaker_data << value
      end
    end

    brains.individual_image.each do |key, value|
      if key == full_name
        full_speaker_data << value
      end
    end

    full_speaker_data
  end

  def fetch_faq_answer(message)
    if (message.split(' ') & keywords['lists']['transport_list']).any?
      brains.get_location_faq("transport/parking")

    elsif (message.split(' ') & keywords['lists']['faq_list']).any?
      brains.get_location_faq("when and")

    elsif (message.split(' ') & keywords['lists']['bathroom_list']).any?
      "bathroom"

    elsif (message.split(' ') & keywords['lists']['food_list']).any?
      ["Yummy lunch menu - Just for you", "We have got some amazing Sandwiches and Wraps - best in town.\nAlso I know you are going to ask about drinks next, so I am preparing to answer that too ;)"]
    
    elsif (message.split(' ') & keywords['lists']['drinks_list']).any?
      ["Liquid for stomach, Energy for Soul", "Tea, Coffee and Water - We have got them all covered for you."]
    
    elsif (message.split(' ') & keywords['lists']['individual_list_1']).any? || (message.split(' ') & keywords['lists']['individual_list']).any?
      "speaker"
    
    elsif (message.split(' ') & keywords['lists']['test_list']).any?
      "test"
    
    elsif (message.split(' ') & keywords['lists']['questions']).any?
      "question"
    
    else
      []
    end
  end

end