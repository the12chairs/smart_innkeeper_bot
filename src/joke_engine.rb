require 'nokogiri'
require 'open-uri'

class Joker
    def initialize
        @url = ENV['JOKE_SOURCE']
    end

    def random()
        html = Nokogiri::HTML.parse(URI.open(@url))
        
        return remove_html_tags(html.at('.anekdot').inner_html)
    end

    def remove_html_tags(joke)
        re = /<("[^"]*"|'[^']*'|[^'">])*>/
        
        return joke.gsub!(re, '')
    end
end