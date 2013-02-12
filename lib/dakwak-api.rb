require 'httparty'
require 'multi_json'
require "dakwak-api/version"

module Dakwak
  module Api
    class Wrapper
      include HTTParty
      base_uri 'https://dakwak.com/api'

      def initialize(apikey)
        raise ArgumentError, "apikey must be a non-empty string" unless is_non_empty_string(apikey)
        @apikey = apikey
      end

      def search(phrase, lang)
        raise ArgumentError, "phrase must be a non-empty string" unless is_non_empty_string(phrase)
        raise ArgumentError, "lang must be a non-empty string" unless is_non_empty_string(lang)
        url = "/search.json?apikey=#{@apikey}&phrase=#{phrase}&lang=#{lang}"
        return MultiJson.load(self.class.post(url).body)
      end

      def get_translation(phrase, lang)
        raise ArgumentError, "phrase must be a non-empty string" unless is_non_empty_string(phrase)
        raise ArgumentError, "lang must be a non-empty string" unless is_non_empty_string(lang)
        url = "/get_translation.json?apikey=#{@apikey}&phrase=#{phrase}&lang=#{lang}"
        return MultiJson.load(self.class.post(url).body)
      end

      def translate(phrases, lang, callback_url="")
        raise ArgumentError, "phrases must be a non-empty array" unless is_non_empty_array(phrases)
        raise ArgumentError, "lang must be a non-empty string" unless is_non_empty_string(lang)
        url = "/translate.json?apikey=#{@apikey}&lang=#{lang}&callback_url=#{callback_url}"
        phrases.each { |phrase| url << "&phrases[]=#{phrase}" }
        return MultiJson.load(self.class.post(url).body)
      end

      def index_pages(pages)
        raise ArgumentError, "pages must be a non-empty array" unless is_non_empty_array(pages)
        url = "/index_pages.json?apikey=#{@apikey}"
        pages.each { |page| url << "&pages[]=#{page}" }
        return MultiJson.load(self.class.post(url).body)
      end

      private
      def is_non_empty_string(arg)
        arg.is_a?(String) && !arg.empty? 
      end
      def is_non_empty_array(arg)
        arg.is_a?(Array) && !arg.empty? 
      end
    end
  end
end