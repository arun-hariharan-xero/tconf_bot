class Responses
  
  def initialize; end

  def respond_message(message, t_link = false, pret = false, t_url = false)
    t_link ||= "https://tconf.io"
    t_url ||= "https://tconf.io/assets/img/backgrounds/bg1.jpg"
    pret ||= ""
    {"attachments" => [{
      "title" => message[0],
      "text" => message[1],
      "title_link" => t_link,
      "thumb_url" => t_url,
      "pretext" => pret}]}.to_json
  end

  def respond_bathroom
    {"attachments" => [{
      "title" => "The toilet is located this way.",
      "image_url" => "https://cdn1.iconfinder.com/data/icons/hands-pt-2/100/097_-_hand_arrow-512.png"
      }]}.to_json
  end

   def respond_normal message    
    {:text => message}.to_json
  end
  
end