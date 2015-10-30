require 'rubygems'
require 'telegram/bot'
require_relative './modules/MessageParser'

class Bot
  def self.run
    token = ENV['API_TOKEN']
    $h = {}

    Thread.new do
      p "Starting bot..."

      Telegram::Bot::Client.run(token) do |bot|
        bot.listen do |message|
          next if message.text.nil?
          if message.text.start_with?('/')
            MessageParser.parse_commands(bot, message)
          else
            MessageParser.parse_plaintext(bot, message)
          end
        end
      end
    end
  end
end
