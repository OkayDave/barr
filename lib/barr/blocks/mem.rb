require 'barr/block'

module Barr
  module Blocks
    class Mem < Block
      def update!
        @output = sys_cmd
      end

      private

      def sys_cmd
        `free -h | grep 'Mem:' | awk '{printf "%s / %sG", $(NF-1), $(NF-1)+$(NF)}'`.chomp
      end
    end
  end
end
