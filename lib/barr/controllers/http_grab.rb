require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false

module Barr
  module Controllers
    class HTTPGrab < Controller
      include Capybara::DSL

      def initialize opts={}
        super
        @type = (opts[:type] || 'css').downcase.to_sym
        @selector = opts[:selector]
        @url = opts[:url]
      end

      def run!
        @thread = Thread.new do
           loop do
            begin
              grabbed = ""
              visit(@url)
              noko = Nokogiri::HTML(page.html)
              
              if @type == :css
                grabbed = noko.css(@selector).first.text
              elsif @type == :xpath
                grabbed = noko.xpath(@selector).first.text
              end

              File.write(filename, {text: grabbed}.to_json)

              sleep @interval
            rescue StandardError => e
              STDERR.puts "HTTPGrab Controller Error"
              STDERR.puts e.message
              STDERR.puts e.backtrace
            end
          end
        end
        @thread.run
      end
    end
  end
end
