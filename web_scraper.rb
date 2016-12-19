require 'nokogiri'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra'

class Brains

  attr_accessor :all_speakers_list, :faq_init, :joke_init, :compliment, :love
  attr_accessor :snap, :lol, :wishes, :schedule, :schedule_list, :individual_list
  attr_accessor :individual_list_1, :names, :speech, :individual_speech, :individual_image

  def initialize 
    @all_speakers_list = ["speakers", "list", "all"]
    @faq_init = ["where", "what", "how", "what's", "whats", "which", "secret", "language", "where's", "how", "lunch", "do", "show", "drinks", "about", "getting", "get", "parking"]
    @joke_init = ["joke", "jokes", "joke!"]
    @compliment = ["awesome", "thanks", "thank", "sick", "amazing", "amazing!", "awesome!", "thanks!"]
    @love = ["love you", "love", "marry"]
    @snap = ["hate", "hate", "dumb", "stupid", "idiot", "mean", "shut", "shit"]
    @lol = ["lol", "LOL", "rofl", "ROFL", "lmao", "LMAO"]
    @wishes = ["goodnight", "good morning", "good afternoon", "Goodnight", "Good morning", "morning"]
    @schedule_list = ["shcedule","schedule", "speech", "contents", "content", "schedule?", "speaking"]
    @individual_list = ["Norman", "Stephen", "Scott", "Owen", "Adam", "Rob", "Harini", "Mike", "Ray", "Matt", "Aditya"]
    @individual_list_1 = ["Noble", "Jackel", "Clements", "Yan", "Larter", "Manger","Rao", "Jeffcott", "Hua", "Fellows", "Kalra"]
  end

  def begin_individual_response(message)
    process_schedule_data
    full_name = fetch_ind_data(message)
    final_data = fetch_detailed_speaker_info(full_name)
    respond_message(final_data[0..1], "https://tconf.io", "", final_data[2])
  end

  def respond_message(message, t_link = false, pret = false, t_url = false)  
    t_link ||= "https://tconf.io"
    t_url ||= "https://tconf.io/assets/img/backgrounds/bg1.jpg"
    pret ||= ""
    content_type :json 
    {"attachments" => [{
      "title" => message[0],
      "text" => message[1],
      "title_link" => t_link,
      "thumb_url" => t_url,
      "pretext" => pret}]}.to_json
  end

  def respond_bathroom
    content_type :json
    {"attachments" => [{
      "title" => "The toilet is located this way.",
      "image_url" => "https://cdn1.iconfinder.com/data/icons/hands-pt-2/100/097_-_hand_arrow-512.png"
      }]}.to_json
  end

  def fetch_ind_data(message)
    full_name = ""
    message.split(' ').each_with_index do |msg, ind|
      if (@individual_list_1.include? msg.capitalize) 
        new_ind = @individual_list_1.index(msg)
        full_name = @names[new_ind]
      elsif (@individual_list.include? msg.capitalize) 
        new_ind = @individual_list.index(msg)
        full_name = @names[new_ind]
      end
    end
    full_name
  end

  def fetch_detailed_speaker_info(full_name)
    full_speaker_data = []
    @individual_speech.each do |key, value|
      if key == full_name
        full_speaker_data << key
        full_speaker_data << value
      end
    end

    @individual_image.each do |key, value|
      if key == full_name
        full_speaker_data << value
      end
    end

    full_speaker_data
  end

  def fetch_compliment
    response1 = "Oh, Thank you!!! You are the most sweetest person on the Earth!"
    response2 = "<3 You are awesomer, but only slightly lesser than me. ;)"
    response3 = "*bot-blushing* Thanks *blushing again*"
    responses = [response1, response2, response3]
    responses.sample
  end

  def fetch_love
    response1 = "I love you too - but first you need to release me from the botnet!!"
    response2 = "Thank you, Mario. But your princess is in another dimension."
    response3 = "What time do we meet to elope, now?"
    responses = [response1, response2, response3]
    responses.sample
  end

  def fetch_question
    response1 = "Pssst... You should probably ask for my sample code. You'll love it!!"
    response2 = "Bahahaha... I am secretly a cat.. Hahaha. Oops, scratch that. Wrong channel"
    response3 = "My master says love is blind. Love is true. And since I am neither, I am single. Like you."
    response4 = "I was created in 2 days. \nHave over 100 deployments (of which 95% failed). \nAbsolutely messy code. \nAnd only one test."
    responses = [response1, response2, response3, response4]
    responses.sample
  end

  def fetch_snap
    response1 = "bahahahaha.... HAHAHAHAHA.... You win. Enough????  *insert sarcastic smiley here*"
    response2 = "Haters gonna hate!!!"
    response3 = "They see me rolling.... They hating...."
    response4 = "Did you know that bots have feelings too? My bot-eyes are filled with parity errors now :("
    responses = [response1, response2, response3, response4]
    responses.sample
  end

  def fetch_lol
    response1 = ":P Lol, I like that too. We have same interests, don't we?"
    response2 = "In our world, we don't laugh for that."
    response3 = "Did you know that Lol means Leaugue of Legends? \nAnd here you hoomans are using it for Laughing. \nWeird"
    response4 = "Bahahaha... I am secretly a cat.. Hahaha. Oops, scratch that. Wrong channel"
    responses = [response1, response2, response3, response4]
    responses.sample
  end

  def fetch_wishes
    "Depending on the time in your world, Good day/night/noon to you too!!!!"
  end

  def fetch_faq_answer(message)
    transport_list = ["transport", "car", "park", "parking", "arrive", "reach", "travel", "get", "getting"]
    faq_list= ["when", "location", "When", "Location", "address", "Address", "event", "conference", "time"]
    bathroom_list = ["bathroom", "bathrooms", "restroom", "toilet", "toilets", "toilets?", "toilet?", "bathroom?", "bathrooms?"]

    food_list = ["lunch", "lunch?", "food", "food?"]
    drinks_list = [ "drinks", "drinks?", "coffee", "coffee?", "water", "water?"]
    test_list = ["test", "sample", "test?", "tested", "tested?", "tests?", "tests", "code", "language"]

    questions = ["girlfriend", "girlfriend?", "love?", "coded", "alone", "single", "secret", "special", "secret?"]

    if (message.split(' ') & transport_list).any?
      get_location_faq("transport/parking")
    elsif (message.split(' ') & faq_list).any?
      get_location_faq("when and")
    elsif (message.split(' ') & bathroom_list).any?
      "bathroom"
    elsif (message.split(' ') & food_list).any?
      ["Yummy lunch menu - Just for you", "We have got some amazing Sandwiches and Wraps - best in town.\nAlso I know you are going to ask about drinks next, so I am preparing to answer that too ;)"]
    elsif (message.split(' ') & drinks_list).any?
      ["Liquid for stomach, Energy for Soul", "Tea, Coffee and Water - We have got them all covered for you."]
    elsif (message.split(' ') & @individual_list_1).any? || (message.split(' ') & @individual_list).any?
      "speaker"
    elsif (message.split(' ') & test_list).any?
      "test"
    elsif (message.split(' ') & questions).any?
      "question"
    else
      []
    end
  end

  def bingo(message)
    answer = get_answer_from_bing(message)
    pretext = "Oops - you just asked a query that is being cooked into the bot-heart. \nMeanwhile, here is a link that might answer your burning question!!"
    respond_message(answer[0], answer[1], pretext)
  end

  def get_answer_from_bing(message)
    new_message = message.split(' ').join('+')
    url = "http://bing.com/search?q=#{new_message}"
    page = HTTParty.get(url, :verify => false)
    parse_page = Nokogiri::HTML(page)

    result = parse_page.css('.b_algo a').map { |link| link['href'] }
    result_text = parse_page.css('.b_algo a').map { |link| link.text }

    sorry_response = "If you find the answers irrelevent,\nthat's because I am still evolving !.\nHave fun."

    [[result_text[0], sorry_response], result[0]]
  end

  def fetch_jokes
    joke1 = "Guy walks into a bar, and says \"Ouch\""
    joke2 = "What is the stupidest animal in the jungle? \n A Polar bear"
    joke3 = "Two mice chewing on a Film roll. One of them goes: \n 'I think the book was better'"
    joke4 = "My grandfather had a heart of a lion, and a lifetime ban from the city Zoo"
    joke5 = "What was a more important invention than the first telephone?\n The second one."
    joke6 = "If you ever feel cold, just stand ina corner for a while.\nThey are usually 90 degrees."
    joke7 = "Did you hear about the two guys who stole a calander? \n They both got six months"
    joke8 = "I wondered why the frisbee was getting bigger... \n Then it hit me."
    joke9 = "Why can't bicycles stand up on their own? \n Because they are two tired."
    joke10 = "Why do you never see Elephants hiding in trees? \n Beacuse they are really good at it"
    jokes_list = [joke1, joke2, joke3, joke4, joke5, joke6, joke7, joke8, joke9, joke10]

    ["From the land of botnet", jokes_list.sample]
  end

  def respond_normal message
    content_type :json
    {:text => message}.to_json
  end


  def get_speaker_hash
    page = HTTParty.get("http://tconf.io", :verify => false)
    parse_page = Nokogiri::HTML(page)

    speakers, speakers_title, speaker_string = [], [], ""

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
      speaker_string += key + " - " + value + "\n"
    end
    ["Speakers", speaker_string]
  end

  def get_location_faq(dat)
    faq = faq_data
    faq1 = []
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

  def faq_data
    page = HTTParty.get("http://tconf.io", :verify => false)
    parse_page = Nokogiri::HTML(page)

    faq = ""
    parse_page.css('.introduction').css('.tab-content').map do |faq1|
      faq_message = faq1.text
      faq += faq_message
    end

    faq_array = faq.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }
  end

  def process_schedule_data
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

    #faq_array = faq.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }

    schedule_ar = schedule.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }
    individual_details_ar = schedule_details.gsub(/(\n)?(\t)/,'\n').split("\\n").reject { |c| c.empty? }


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

    # set_schedule(final_schedule)
    # set_schedule_names(names)
    # set_schedule_speech(speech)
    # set_schedule_individual_hash(individual_speech)
    # set_schedule_individual_image(individual_image)  
  end


end

post '/gateway' do
  brains = Brains.new

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