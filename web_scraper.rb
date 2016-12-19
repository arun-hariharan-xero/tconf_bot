require_relative 'bot_brains'

require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'

post '/gateway' do
  brains = BotBrains.new

  message = params[:text].gsub(params[:trigger_word], '').strip

  if (message.split(' ') & brains.all_speakers_list).any?
    brains.respond_message(brains.get_speaker_hash)
  elsif (message.split(' ') & brains.faq_init).any?
    answer = brains.fetch_faq_answer(message)
    if answer == "speaker"
      brains.begin_individual_response(message)
    elsif answer == []
       brains.bingo(message)
    elsif answer == "test"
      code1 = "My only test case - Guess the language ;) \n```describe '#please_run_i_beg_you' do \n\tcontext 'when bot is running' do\n\t\tit { is_expected.to be_running }\n\tend\nend```"
      code2 = "I *swear* this is in my code. \nI guess *my master* likes to just *watch the world burn*!!\n```elsif answer == \"question\"\n\trespond_answer(question)\nend```"
      code = [code1, code2]
      brains.respond_normal(code.sample)
    elsif answer == "question"
      brains.respond_normal(fetch_question)
    elsif answer == "bathroom"
      brains.respond_bathroom
    else
      brains.respond_message(answer)
    end
  elsif (message.split(' ') & brains.joke_init).any?
    brains.respond_message(fetch_jokes)
  elsif (message.split(' ') & brains.compliment).any?
    brains.respond_normal(fetch_compliment)
  elsif (message.split(' ') & brains.love).any?
    brains.respond_normal(fetch_love)
  elsif (message.split(' ') & brains.snap).any?
    brains.respond_normal(fetch_snap)
  elsif (message.split(' ') & brains.lol).any?
    brains.respond_normal(fetch_lol)
  elsif (message.split(' ') & brains.wishes).any?
    brains.respond_normal(fetch_wishes)
  elsif (message.split(' ') & brains.individual_list_1).any? || (message.split(' ') & brains.individual_list).any?
    brains.begin_individual_response(message)
  elsif (message.split(' ') & brains.schedule_list).any?
    brains.process_schedule_data
    brains.respond_message(["The Schedule for the day:", brains.final_schedule.join("\n")])  
  else
    brains.bingo(message)
  end

  #Pry.start(binding)  
end