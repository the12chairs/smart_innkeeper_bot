#!/usr/bin/ruby

require 'telegram/bot'
require 'dotenv/load'
require './joke_engine'

Dotenv.load('.env')

token = ENV['TELEGRAM_APITOKEN']

joke = Joke.new

loop do
    Telegram::Bot::Client.run(token) do |bot|
        bot.listen do |rqst|
            Thread.start(rqst) do |rqst|
                case rqst.text
                    when '/разрывная'
                        anek = joke.random()
                        while anek  == nil
                            anek = joke.random()
                        end
                        bot.api.send_message(chat_id: rqst.chat.id, text: anek)
                    when '/наливай'
                        bot.api.sendPhoto(chat_id: rqst.chat.id, caption: "Держи кружечку", photo: "http://c.files.bbci.co.uk/6932/production/_92803962_thinkstockphotos-92218902.jpg")
                end
            end
        end
    end
end
