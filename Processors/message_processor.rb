require_relative '../Response/responses'
require_relative '../Processors/fetchers'
require_relative "../Processors/request_processor"

class MessageProcessor

  attr_reader :response, :keywords, :brains, :fetcher, :request

  def initialize(keywords, brains)
    @response = Responses.new
    @keywords = keywords
    @brains = brains
    @request = RequestProcessor.new(brains)
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
      brains.process_schedule_data
      response.respond_message(["The Schedule for the day:", brains.final_schedule.join("\n")])  

    else
      brains.bingo(message)
    end
  end

  def respond_with_correct_faq(message)
    answer = fetcher.fetch_faq_answer(message)
    if answer == "speaker"
      brains.begin_individual_response(message)
    elsif answer == []
       brains.bingo(message)
    elsif answer == "test"
      code1 = "My only test case - Guess the language ;) \n```describe '#please_run_i_beg_you' do \n\tcontext 'when bot is running' do\n\t\tit { is_expected.to be_running }\n\tend\nend```"
      code2 = "I *swear* this is in my code. \nI guess *my master* likes to just *watch the world burn*!!\n```elsif answer == \"question\"\n\trespond_answer(question)\nend```"
      code = [code1, code2]
      response.respond_normal(code.sample)
    elsif answer == "question"
      response.respond_normal(fetcher.fetch_question)
    elsif answer == "bathroom"
      response.respond_bathroom
    else
      response.respond_message(answer)
    end
  end

end