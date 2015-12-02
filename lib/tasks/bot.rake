# require 'config/environment'

desc "start the telegram bot"
task :bot => :environment do
  ruby "#{Rails.root}/bot/bot.rb"
end
