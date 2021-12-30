require './src/env_loader.rb'
require 'telegram/bot'

token = ENV['TELEGRAM_APITOKEN']

chat_id = File.foreach('./res/group_id.txt', 'r').first

bot = Telegram::Bot::Client.new(token)

sleep (rand(1..100))
bot.api.send_message(chat_id: chat_id, text: 'Вы чего притихли? Почему вас не слышно?')