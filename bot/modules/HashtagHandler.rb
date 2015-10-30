require 'rubygems'
require 'telegram/bot'

class HashtagHandler
  def self.add_new_message(message, hashtag)
    user = message.from.first_name + message.from.last_name
    m = Message.create(user: user, text: message.text, hashtag: hashtag)
  end

  def self.add_new_hashtag(hashtag_string)
    hashtag = Hashtag.create(name: hashtag_string)
    hashtag
  end

  def self.handle_hashtags(bot, message, hashtag_string)
    hashtag = Hashtag.where(name: hashtag_string.downcase).first
    hashtag = self.add_new_hashtag(hashtag_string) if hashtag.nil?
    self.add_new_message(message,hashtag)
  end

  # def self.count_hashtags(bot, message)
  #   hashtag
  # end
end
