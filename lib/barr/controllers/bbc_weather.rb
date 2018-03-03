require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'

module Barr
  module Controllers
    class BBCWeather < Controller
      def initialize(opts = {})
        super
        @temp_unit = (opts[:temp_unit] || 'c').downcase
        @speed_unit = (opts[:speed_unit] || 'mph').downcase
      end

      def run!
        @thread = Thread.new do
          loop do
            begin
              url = "https://www.bbc.co.uk/weather/0/#{@id}"

              op = {}

              noko = Nokogiri::HTML(open(url))

              op[:temperature] = noko.css("div.wr-value--temperature .wr-value--temperature--#{@temp_unit} .wr-hide-visually").text
              op[:summary] = noko.css('.wr-day__weather-type-description-container')[0].text
              op[:windspeed] = noko.css("span.wr-wind-speed__icon span[data-unit=#{@speed_unit}]")[0].text
              op[:winddirection] = noko.css('span.wind-rose__direction-abbr')[0].text.delete(' ')

              hvp = noko.css('li.wr-c-station-data__observation')
              op[:humidity] = hvp[0].text
              op[:visibility] = hvp[1].text
              op[:pressure] = hvp[2].text

              File.write(filename, op.to_json)

              sleep 600
            rescue StandardError => e
              STDERR.puts 'thread error!'
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
