class Keywords

  attr_accessor :all_speakers_list, :faq_init, :joke_init, :compliment, :love
  attr_accessor :snap, :lol, :wishes, :schedule, :schedule_list, :individual_list
  attr_accessor :individual_list_1

  def initialize
  end

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
end