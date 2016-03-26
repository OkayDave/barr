module Barr
  module Blocks
    class Mem < Block

      def update
        @output = sys_cmd.chomp
      end

      def sys_cmd
        `free -m | grep Mem | awk '{printf "%sM / %sM", $3, $2}'`
      end
    end
  end
  
end
