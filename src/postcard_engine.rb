require 'nokogiri'
require 'open-uri'

class Postcarder

    def initialize
        @url = 'https://animaski.ru/'
    end

    def get_one 
        page = Nokogiri::HTML.parse(URI.open(@url))
        return page.at('img').attr('src')
    
    end
end