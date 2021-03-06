require_relative '../Response/responses'
require_relative '../Processors/fetchers'

class BotBrains

  attr_reader :response, :keywords, :names, :speech, :individual_speech, :individual_image
  attr_reader :speaker_string, :final_schedule
  

  def initialize(keywords)
    @response = Responses.new
    @keywords = keywords
  end

  def bing_answer_for(message)
    get_answer_from_bing(message)
  end

  def get_speaker_hash
    process_speaker_data
    ["Speakers", speaker_string]
  end

  def process_schedules
    process_each_schedule
  end

  def get_location_faq(dat)
    faq = process_faq_details(dat)
  end

  private

  def faq_data
    page = HTTParty.get("http://tconf.io", :verify => false)
    parse_page = Nokogiri::HTML(page)

    faq = ""
    parse_page.css('.introduction').css('.tab-content').map do |faq1|
      faq_message = faq1.text
      faq += faq_message
    end

    faq_array = gsub_and_reject_empty(faq)
  end

  def process_faq_details(dat)
    faq, faq1 = faq_data, []
    faq.each_with_index do |data, ind|
      if data.downcase.include? dat
        faq1 << data
        faq1 << faq[ind + 1]
        if dat == "transport/parking"
          faq1[1] += " .\n" + faq[ind + 2]
          faq1[1] += " .\n" + faq[ind + 3]
          faq1[1] += " .\n" + faq[ind + 4]
        end
      end
    end
    faq1
  end

  def process_speaker_data
    page = HTTParty.get("http://tconf.io", :verify => false)
    parse_page = Nokogiri::HTML(page)

    speakers, speakers_title, @speaker_string = [], [], ""

    parse_page.css('.speaker').css('.name').map do |name|
      speaker_name = name.text
      speakers << speaker_name
    end

    parse_page.css('.speaker').css('.text-alt').map do |title|
      speaker_title = title.text
      speakers_title << speaker_title
    end

    # Map speakers with their title and company as a hash
    speaker_hash = Hash[speakers.zip(speakers_title)]
    speaker_hash.each do |key, value|
      @speaker_string += key + " - " + value + "\n"
    end
  end

  def get_answer_from_bing(message)
    new_message = message.split(' ').join('+')
    url = "http://bing.com/search?q=#{new_message}"
    page = HTTParty.get(url, :verify => false)
    parse_page = Nokogiri::HTML(page)

    result = parse_page.css('.b_algo a').map { |link| link['href'] }
    result_text = parse_page.css('.b_algo a').map { |link| link.text }

    sorry_response = keywords["responses"]["sorry"].values[0]

    [[result_text[0], sorry_response], result[0]]
  end

  def process_each_schedule
    page = HTTParty.get("http://tconf.io", :verify => false)
    parse_page = Nokogiri::HTML(page)

    schedule, schedule_details = "", ""
    parse_page.css('.schedule-item-toggle').map do |faq1|
      faq_message = faq1.text
      schedule += faq_message
    end

    parse_page.css("#day1_auditorium1_time1").map do |faq1|
      faq_message = faq1.text
      schedule_details += faq_message
    end

    thumb_image = parse_page.css('#day1_auditorium1').css('.panel-group').css('.schedule-item').css('.lecture-icon-wrapper img').map do |img| 
      "http://tconf.io/" + img['src']
    end

    schedule_ar = gsub_and_reject_empty(schedule)
    individual_details_ar = gsub_and_reject_empty(schedule_details)

    new_ar = schedule_ar.each_with_index.map do |data, ind|
      next if (ind % 2 != 0)
      schedule_ar[ind..ind + 1].join(' : ')
    end

    @final_schedule = new_ar.reject { |c| c.nil? }

    individual_details_ar.reject! { |c| c.empty? }
    individual_details_ar.delete_at(0)
    individual_details_ar.delete_at(2)
    individual_details_ar.delete_at(10)
    individual_details_ar.delete_at(18)

    @names, @speech = [], []
    individual_details_ar.each_with_index.map do |data, ind|
      (ind % 2 == 0) ? (@speech << data) : (@names << data)
    end

    @individual_speech = Hash[@names.zip(@speech)]
    @individual_image = Hash[@names.zip(thumb_image)]
  end

  def gsub_and_reject_empty(array)
    array.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }
  end

end