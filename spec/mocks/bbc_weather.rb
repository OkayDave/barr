# coding: utf-8
require 'barr/block'
require 'barr/controller'
require 'barr/blocks/bbc_weather'
require 'barr/controllers/bbc_weather'
require 'nokogiri'

module Barr
  module Controllers
    class BBCWeatherControllerMock < Barr::Controllers::BBCWeather
      
      def document
      end
      
      def run!
      end
      
      def update!
        @output ||= {}
        @output[:temperature] = "17 C"
        @output[:summary] = "Nice outside"
        @output[:windspeed] = "5 mp/h"
      end
      
    end
  end


  module Blocks
    class BBCWeatherBlockMock < Barr::Blocks::BBCWeather
      def config
        opts = {id: @location}
        @controller = Barr::Controllers::BBCWeatherControllerMock.new opts
      end
    end
  end
end


