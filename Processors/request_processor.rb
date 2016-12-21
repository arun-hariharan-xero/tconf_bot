require_relative "../Scraper/bot_brains"

class RequestProcessor
  attr_reader :brains, :fetcher, :response, :keywords

  def initialize(keywords, brains, response)
    @brains = brains
    @response = response
    @keywords = keywords
    @fetcher = Fetchers.new(keywords, brains)
  end

  def begin_individual_response(message)
    brains.process_schedules
    full_name = fetcher.fetch_ind_data(message)
    final_data = fetcher.fetch_detailed_speaker_info(full_name)
    response.respond_message(final_data[0..1], "https://tconf.io", "", final_data[2])
  end

  def bingo(message)
    answer = brains.bing_answer_for(message)
    pretext = keywords["texts"].values[0]
    response.respond_message(answer[0], answer[1], pretext)
  end
end