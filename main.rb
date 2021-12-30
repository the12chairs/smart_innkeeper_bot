#!/usr/bin/ruby

require './src/env_loader.rb'
require './src/joke_engine'
require './src/postcard_engine.rb'

require 'telegram/bot'
token = ENV['TELEGRAM_APITOKEN']

joker = Joker.new
postcarder = Postcarder.new

greet = false

chat_id = File.foreach('./res/group_id.txt', 'r').first

last_time = Time.now.to_i

loop do
 
    Telegram::Bot::Client.run(token) do |bot|

        if !greet && chat_id != nil
            bot.api.send_message(chat_id: chat_id, text: 'Здарова, пидоры! Я родился, епта. (бот перезапущен)')
            greet = true
        end

        bot.listen do |rqst|
            Thread.start(rqst) do |rqst|

                case rqst.text

                    when '/запомни_чат'
                        File.open('./res/group_id.txt', 'w') {
                            |file| file.write(rqst.chat.id)
                        }

                        bot.api.send_message(chat_id: rqst.chat.id, text: 'Группа отмечена, как основная')

                    when '/разрывная'
                        anek = joker.random()
                        while anek  == nil
                            anek = joker.random()
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
