module Barr
  module Blocks
    class Cpu < Block 
      def update
        @output = `top -bn1 | grep load | awk '{print $(NF-2)+$(NF-1)+$(NF)}'`.chomp + "%"
      end
    end
  end
end
