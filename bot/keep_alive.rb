# This script is NOT meant to be started by the app!
# It should be started by a scheduled or cron job.

require 'telegram/bot'
require 'rufus-scheduler'

token = ENV['API_TOKEN']
chat_id = ENV['KEEP_ALIVE_CHAT_ID']

scheduler = Rufus::Scheduler.new

Telegram::Bot::Client.run(token) do |bot|
  scheduler.every '10min', :last_at => Time.now + 18 * 3600 do
    bot.api.send_message(chat_id: chat_id, text: "Hello world!")
  end
end
