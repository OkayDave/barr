module Barr
  module Blocks
    class BBCWeather < Block
      attr_accessor :location

      def initialize opts={}
        super
        @location = opts[:location]
        @format = opts[:format] || "${TEMPERATURE} - ${SUMMARY}"
        @temp_unit = opts[:temp_unit] || "c"
        @speed_unit = opts[:speed_unit] || "mph"
      end

      def config
        opts = {id: @location, temp_unit: @temp_unit, speed_unit: @speed_unit }
        @controller  = @manager.controller :BBCWeather, opts
      end

      def update!
        op = @controller.output
        @output = "%{A:barr_open_url http www.bbc.co.uk\/weather\/#{@location}:}#{format_string_from_hash(op)}%{A}"
      end
      
      
    end
  end
end
