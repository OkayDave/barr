# coding: utf-8
module Barr
  module Blocks
    class Temperature < Block
      attr_reader :location, :unit

      def initialize opts={}
        super
        @location = opts[:location]
        @unit = opts[:unit] || "C"
      end

      def update
        res = weather_data
        temp = (@unit == 'C' ? ((res.condition.temp.to_i-32)*(5/9.0)).round : res.condition.temp)
        action = "xdg-open weather.yahoo.com\/country\/state\/city-#{@location}\/".chomp
        @output = "%{A:#{action}:}#{temp}°#{@unit} #{res.condition.text}%{A}"
      end

      def weather_data
        Weather.lookup(@location, Weather::Units::FAHRENHEIT)
      end
      
    end
  end
end
