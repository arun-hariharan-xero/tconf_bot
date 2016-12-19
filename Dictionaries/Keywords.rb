class Keywords

  attr_reader :all_speakers_list, :faq_init, :joke_init, :compliment, :love
  attr_accessor :snap, :lol, :wishes, :schedule, :schedule_list, :individual_list
  attr_reader :individual_list_1, :transport_list, :faq_list, :bathroom_list
  attr_reader :food_list, :drinks_list, :test_list, :questions

  def initialize
    keyword_list
    other_list
  end

  private 
  
  def keyword_list
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

  def other_list
    @transport_list = ["transport", "car", "park", "parking", "arrive", "reach", "travel", "get", "getting"]
    @faq_list= ["when", "location", "When", "Location", "address", "Address", "event", "conference", "time"]
    @bathroom_list = ["bathroom", "bathrooms", "restroom", "toilet", "toilets", "toilets?", "toilet?", "bathroom?", "bathrooms?"]
    @food_list = ["lunch", "lunch?", "food", "food?"]
    @drinks_list = [ "drinks", "drinks?", "coffee", "coffee?", "water", "water?"]
    @test_list = ["test", "sample", "test?", "tested", "tested?", "tests?", "tests", "code", "language"]
    @questions = ["girlfriend", "girlfriend?", "love?", "coded", "alone", "single", "secret", "special", "secret?"]
  end
end
