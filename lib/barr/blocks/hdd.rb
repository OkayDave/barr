module Barr
  module Blocks
    class Hdd < Block

      attr_reader :device
      def initialize opts={}
        super
        @device = opts[:device]
      end

      def update
        total, used, perc = `df -h | grep #{@device} | awk '{printf "%s %s %s", $2, $3, $5}'`.chomp.split(" ")
        @output = "#{used} / #{total} (#{perc})"                                                              
      end
    end

  end
end
