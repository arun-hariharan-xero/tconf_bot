require_relative '../Response/responses'
require_relative '../Processors/fetchers'
require_relative "../Processors/request_processor"

class MessageProcessor

  attr_reader :response, :keywords, :brains, :fetcher, :request

  def initialize(keywords, brains)
    @response = Responses.new
    @keywords = keywords
    @brains = brains
    @request = RequestProcessor.new(keywords, brains, response)
    @fetcher = Fetchers.new(keywords, brains)
  end

  def process(message)
    matching =  message.split(' ') & keywords['lists'].values.flatten

    key1 = keywords['lists'].select do |key, values|
      key if (matching & values).any?
    end

    (key1.empty?) ? match_tertiary_cases(message, "Unknown") : match_primary_cases(message, key1.first[0])
  end

  private

  def match_primary_cases(message, key)
    case key
    when "all_speakers_list"      
      response.respond_message(brains.get_speaker_hash)
    when "individual_list_1"
      request.begin_individual_response(message)
    when "individual_list"
      request.begin_individual_response(message)
    when "schedule_list" 
      handle_schedule
    else
      match_secondary_cases(message, key)
    end
  end

  def match_secondary_cases(message, key)
    case key
    when "joke_init" 
      response.respond_message(fetcher.fetch_jokes)
    when "compliment" 
      response.respond_normal(fetcher.fetch_compliment)
    when "wishes"
      response.respond_normal(fetcher.fetch_wishes)
    else
      match_tertiary_cases(message, key)
    end
  end

  def match_tertiary_cases(message, key)
    case key
    when "love" 
      response.respond_normal(fetcher.fetch_love)
    when "snap" 
      response.respond_normal(fetcher.fetch_snap)
    when "lol"
      response.respond_normal(fetcher.fetch_lol)
    else
      respond_with_correct_faq(message)
    end
  end

  def respond_with_correct_faq(message)
    answer = fetcher.fetch_faq_answer(message)

    case answer
    when 'speaker'
      request.begin_individual_response(message)
    when []
       request.bingo(message)
    when 'test'
      keywords["responses"]["fetch_code"].values.sample
    when 'question'
      response.respond_normal(fetcher.fetch_question)
    when 'bathroom'
      response.respond_bathroom
    else
      response.respond_message(answer)
    end
  end

  def handle_schedule
    brains.process_schedules
    response.respond_message(["The Schedule for the day:", brains.final_schedule.join("\n")]) 
  end


end