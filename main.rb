#!/usr/bin/ruby

require './src/env_loader.rb'
require './src/joke_engine'
require './src/postcard_engine.rb'

require 'telegram/bot'
token = ENV['TELEGRAM_APITOKEN']

joke = Joke.new
postcarder = Postcarder.new

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
                        bot.api.send_photo(chat_id: rqst.chat.id, caption: "Держи кружечку", photo: "http://c.files.bbci.co.uk/6932/production/_92803962_thinkstockphotos-92218902.jpg")
                    when '/гифка'
                        bot.api.send_video(chat_id: rqst.chat.id, video: postcarder.get_one)
                end
            end
        end
    end
end
