module Barr
  module Blocks
    class Mem < Block

      def update
        @output = `free -m | grep Mem | awk '{printf "%sM / %sM", $3, $2}'`.chomp
      end
    end
  end
  
end
