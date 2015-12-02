require 'rubygems'
require 'telegram/bot'
require_relative '../config/environment'
require_relative './modules/MessageParser'

token = ENV['API_TOKEN']
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
