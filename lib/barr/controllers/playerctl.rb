require 'json'

module Barr
  module Controllers
    class Playerctl < Controller

      def initialize opts={}
        super
        @player = opts[:player] || ""
      end

      def run!
        @thread = Thread.new do
          loop do
            begin
              op = {}

              op[:album] = sys_cmd 'album'
              op[:artist] = sys_cmd 'artist'
              op[:title] = sys_cmd 'title'

              File.write(filename, op.to_json)

              sleep 5
            rescue StandardError => e
              STDERR.puts "thread error!"
              STDERR.puts e.message
              STDERR.puts e.backtrace
            end

          end
        end
        @thread.run
      end

      def sys_cmd key
        if !@player.empty?
          `playerctl -p #{@player} metadata #{key}`
        else
          `playerctl metadata #{key}`
        end
      end

    end
  end
end
