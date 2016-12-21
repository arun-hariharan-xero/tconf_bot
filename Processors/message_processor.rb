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
    if (message.split(' ') & keywords['lists']['all_speakers_list']).any?
      response.respond_message(brains.get_speaker_hash)

    elsif (message.split(' ') & keywords['lists']['faq_init']).any?
      respond_with_correct_faq(message)

    elsif (message.split(' ') & keywords['lists']['joke_init']).any?
      response.respond_message(fetcher.fetch_jokes)

    elsif (message.split(' ') & keywords['lists']['compliment']).any? 
      response.respond_normal(fetcher.fetch_compliment)

    elsif (message.split(' ') & keywords['lists']['love']).any?
      response.respond_normal(fetcher.fetch_love)

    elsif (message.split(' ') & keywords['lists']['snap']).any?
      response.respond_normal(fetcher.fetch_snap)

    elsif (message.split(' ') & keywords['lists']['lol']).any?
      response.respond_normal(fetcher.fetch_lol)

    elsif (message.split(' ') & keywords['lists']['wishes']).any?
      response.respond_normal(fetcher.fetch_wishes)

    elsif (message.split(' ') & keywords['lists']['individual_list_1']).any? || (message.split(' ') & keywords['lists']['individual_list']).any?
      request.begin_individual_response(message)

    elsif (message.split(' ') & keywords['lists']['schedule_list']).any?
      brains.process_schedules
      response.respond_message(["The Schedule for the day:", brains.final_schedule.join("\n")])  

    else
      request.bingo(message)
    end
  end

  def respond_with_correct_faq(message)
    answer = fetcher.fetch_faq_answer(message)
    if answer == "speaker"
      request.begin_individual_response(message)
    elsif answer == []
       request.bingo(message)
    elsif answer == "test"
      keywords["responses"]["fetch_code"].values.sample
    elsif answer == "question"
      response.respond_normal(fetcher.fetch_question)
    elsif answer == "bathroom"
      response.respond_bathroom
    else
      response.respond_message(answer)
    end
  end

end