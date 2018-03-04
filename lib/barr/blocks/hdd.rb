require 'barr/block'

module Barr
  module Blocks
    class HDD < Block
      def initialize(opts = {})
        super

        @device = opts[:device]
      end

      def update!
        total, used, perc = sys_cmd.split(' ')

        @output = "#{used} / #{total} (#{perc})"
      end

      private

      def sys_cmd
        `df -h | grep #{@device} | awk '{printf "%s %s %s", $2, $3, $5}'`.chomp
      end
    end

    Hdd = HDD
  end
end
