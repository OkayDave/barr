module Barr
  module Blocks
    class Hdd < Block
      attr_reader :device
      def initialize opts={}
        super
        @device = opts[:device]
      end

      def update
        total, used, perc = sys_cmd.chomp.split(" ")
        @output = "#{used} / #{total} (#{perc})"                                                              
      end

      def sys_cmd
        `df -h | grep #{@device} | awk '{printf "%s %s %s", $2, $3, $5}'`
      end
    end

  end
end
