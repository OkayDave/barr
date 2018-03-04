
require 'weather-api'
require 'barr/block'

module Barr
  module Blocks
    class Temperature < Block
      attr_reader :location

      def initialize(opts = {})
        super

        @location = opts[:location]
        @unit = opts[:unit] || 'C'
      end

      def update!
        action = "xdg-open 'https\:\/\/weather.yahoo.com\/country\/state\/city-#{@location}\/'"
        @output = "%{A:#{action}:}#{weather.condition.temp}°#{@unit} #{weather.condition.text}%{A}"
      end

      private

      def weather
        Weather.lookup(@location, weather_units)
      end

      def weather_units
        @unit == 'F' ? Weather::Units::FAHRENHEIT : Weather::Units::CELSIUS
      end
    end
  end
end
