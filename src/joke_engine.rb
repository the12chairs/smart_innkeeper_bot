require 'nokogiri'
require 'open-uri'

class Joke
    def initialize
        @url = ENV['JOKE_SOURCE']
    end

    def random()
        html = Nokogiri::HTML.parse(URI.open(@url))
        
        return remove_html_tags(html.at('.text.desktop').inner_html)
    end

    def remove_html_tags(joke)
        re = /<("[^"]*"|'[^']*'|[^'">])*>/
        
        return joke.gsub!(re, '')
    end
end