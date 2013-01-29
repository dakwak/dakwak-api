require 'httparty'
require "dakwak-api/version"

module Dakwak
  module Api
    class Wrapper
      include HTTParty
      # base_uri 'https://dakwak.com/api'
      base_uri 'http://localhost:3000/api'

      def initialize(apikey)
        @apikey = apikey
      end

      def search(phrase, lang)
        url = "/search.json?apikey=#{@apikey}&phrase=#{phrase}&lang=#{lang}"
        return self.class.post(url)
      end

      def get_translation(phrase, lang)
        url = "/get_translation.json?apikey=#{@apikey}&phrase=#{phrase}&lang=#{lang}"
        return self.class.post(url)
      end

      def translate(phrases, lang, callback_url="")
        url = "/translate.json?apikey=#{@apikey}&lang=#{lang}&callback_url=#{callback_url}"
        phrases = [phrases] unless phrases.is_a?(Array)
        phrases.each { |phrase| url << "&phrases[]=#{phrase}" }
        return self.class.post(url)
      end

      def index_pages(pages)
        url = "/index_page.json?apikey=#{@apikey}"
        pages = [pages] unless pages.is_a?(Array) 
        pages.each { |page| url << "&pages[]=#{page}" }
        return self.class.post(url)
      end
    end
  end
end