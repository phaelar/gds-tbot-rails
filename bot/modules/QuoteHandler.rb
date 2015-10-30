require 'rubygems'
require 'telegram/bot'
require 'yaml'

class QuoteHandler

  def self.get_random_quote
    total_quotes = Quote.count
    if total_quotes >= 1
      chosen = Quote.find(rand(1..total_quotes))
      "#{chosen.author}: \n #{chosen.phrase}"
    else
      "Sorry, there are no quotes yet!"
    end
  end

  def self.add_to_quotes(author, phrase)
    Quote.create(author: author, phrase: phrase, sensitive: false)
  end

  def self.handle_quotes(bot,message)
    p 'parsing quotes'

    message_arr = message.text.split
    case message_arr[0]
    when "/qotd"
      bot.api.send_message(chat_id: message.chat.id, text: self.get_random_quote)
    when "/qotd_add"
      message.text.slice! "/qotd_add"
      author_raw = /<.+>/.match(message.text).to_s
      message.text.slice! author_raw.to_s
      message.text.slice " "

      author = author_raw[1..-2]
      phrase = message.text[1..-1]
      self.add_to_quotes(author, phrase)
      bot.api.send_message(chat_id: message.chat.id, text: "Quote added! \n#{author}: #{message.text}")
    end
  end
end
