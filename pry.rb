require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'

page = HTTParty.get("http://tconf.io", :verify => false)
  parse_page = Nokogiri::HTML(page)
  faq = ""

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

  #faq_array = faq.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }

  schedule_ar = schedule.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }
  individual_details_ar = schedule_details.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }

  new_ar = schedule_ar.each_with_index.map do |data, ind|
  	next if (ind % 2 != 0)
  	schedule_ar[ind..ind + 1].join(' : ')
  end

  final_schedule = new_ar.reject { |c| c.nil? }

  individual_details_ar.reject! { |c| c.empty? }
  individual_details_ar.delete_at(0)
  individual_details_ar.delete_at(2)
  individual_details_ar.delete_at(10)
  individual_details_ar.delete_at(18)

  names, speech = [], []
  individual_details_ar.each_with_index.map do |data, ind|
  	(ind % 2 == 0) ? (speech << data) : (names << data)
  end

  individual_speech = Hash[names.zip(speech)]
  individual_image = Hash[names.zip(thumb_image)]

  # names  = names.reject { |c| c.nil? }

  # descrip = individual_details_ar.each_with_index do |data, ind|
  # 	individual_details_ar.delete_at(ind) if (ind % 2 != 0)
  # end

  # sch2 = []
  # schedule_details_ar.each_with_index do |data, ind|
  #   if data.downcase.include? "keynote"
  #     sch2 << data
  #     sch2 << schedule_details_ar[ind - 1]
  #     sch2
  #   end
  # end

  # faq1 = []
  # faq_array.each_with_index do |data, ind|
  #   if data.downcase.include? "keynote"
  #     faq1 << data
  #     faq1 << faq_array[ind - 1]
  #     faq1
  #   end
  # end

  Pry.start(binding)