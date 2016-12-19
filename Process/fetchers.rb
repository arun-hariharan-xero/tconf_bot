class Fetchers

  attr_reader :keywords

  def initialize(keywords)
    @keywords = keywords
  end

  def fetch_ind_data(message)
    full_name = ""
    message.split(' ').each_with_index do |msg, ind|
      if (keywords.individual_list_1.include? msg.capitalize) 
        new_ind = keywords.individual_list_1.index(msg)
        full_name = names[new_ind]
      elsif (keywords.individual_list.include? msg.capitalize) 
        new_ind = keywords.individual_list.index(msg)
        full_name = names[new_ind]
      end
    end
    full_name
  end

  def fetch_detailed_speaker_info(full_name)
    full_speaker_data = []
    keywords.individual_speech.each do |key, value|
      if key == full_name
        full_speaker_data << key
        full_speaker_data << value
      end
    end

    keywords.individual_image.each do |key, value|
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
    if (message.split(' ') & keywords.transport_list).any?
      get_location_faq("transport/parking")
    elsif (message.split(' ') & keywords.faq_list).any?
      get_location_faq("when and")
    elsif (message.split(' ') & keywords.bathroom_list).any?
      "bathroom"
    elsif (message.split(' ') & keywords.food_list).any?
      ["Yummy lunch menu - Just for you", "We have got some amazing Sandwiches and Wraps - best in town.\nAlso I know you are going to ask about drinks next, so I am preparing to answer that too ;)"]
    elsif (message.split(' ') & keywords.drinks_list).any?
      ["Liquid for stomach, Energy for Soul", "Tea, Coffee and Water - We have got them all covered for you."]
    elsif (message.split(' ') & keywords.individual_list_1).any? || (message.split(' ') & keywords.individual_list).any?
      "speaker"
    elsif (message.split(' ') & keywords.test_list).any?
      "test"
    elsif (message.split(' ') & keywords.questions).any?
      "question"
    else
      []
    end
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

end