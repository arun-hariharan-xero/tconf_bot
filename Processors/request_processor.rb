require_relative "../Scraper/bot_brains"

class RequestProcessor
  attr_reader :brains

  def initialize(brains)
    @brains = brains
  end

  def begin_individual_response(message)
    brains.process_schedule_data
    full_name = fetcher.fetch_ind_data(message)
    final_data = fetcher.fetch_detailed_speaker_info(full_name)
    response.respond_message(final_data[0..1], "https://tconf.io", "", final_data[2])
  end
end