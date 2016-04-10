require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'

module Barr
  module Controllers
    class BBCWeather < Controller

      def initialize opts={}
        super
        @temp_unit = (opts[:temp_unit] || "c").downcase
        @speed_unit = (opts[:speed_unit] || "mph").downcase
      end
      
      def update!
        @output = JSON.parse(`cat #{filename}`, symbolize_names: true)
      end

      def run!
        @thread = Thread.new do  
          loop do 
            begin 
              url = "http://www.bbc.co.uk/weather/#{@id}"
  
              op = {}
  
              noko = Nokogiri::HTML(open(url))

              op[:temperature] = noko.css("div.observationsRecord span.units-value.temperature-value.temperature-value-unit-#{@temp_unit}").text
              op[:summary] = noko.css("div.observationsRecord p.weather-type img").attribute("alt").value
              op[:windspeed] = noko.css("div.observationsRecord span.speed span.units-values.windspeed-units-values span.windspeed-value-unit-#{@speed_unit}").text
              op[:winddirection] = noko.css("div.observationsRecord p.wind-speed span.wind.wind-speed").attribute("data-tooltip-mph").value.split(", ")[1]
              op[:humidity] = noko.css("div.observationsRecord p.humidity span.data").text
              op[:visibility] = noko.css("div.observationsRecord p.visibility span.data").text
              op[:pressure] = noko.css("div.observationsRecord p.pressure span.data").text
              
              File.write(filename, op.to_json)
  
              sleep 600
            rescue StandardError => e
              STDERR.puts "thread error!"
              STDERR.puts e.message
              STDERR.puts e.backtrace
            end

          end
          
        end
        @thread.run
      end

      def document(url)
        Nokogiri::HTML(open(url))
      end

    end
  end
end
