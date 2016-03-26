module Barr
  module Blocks

    class WhoAmI < Block
      def initialize opts={}
        super 
        @output = sys_cmd 
      end

      def sys_cmd
        `whoami`.chomp
      end
    end
  end
end
