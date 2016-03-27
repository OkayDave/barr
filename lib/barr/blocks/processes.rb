module Barr
  module Blocks

    class Processes < Block
      def initialize opts={}
        super 
        @output = sys_cmd
      end

      def sys_cmd
        `ps -e | wc -l`
      end
    end
  end
end
