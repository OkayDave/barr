require 'barr/block'

module Barr
  module Blocks

    class Processes < Block
      def update!
	      @output = sys_cmd
      end

      def sys_cmd
        `ps -e | wc -l`.chomp
      end
    end
  end
end
