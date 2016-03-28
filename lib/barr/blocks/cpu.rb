require 'barr/block'

module Barr
  module Blocks
    class CPU < Block

      def update!
        idle = sys_cmd.scan(/(\d{1,3}\.\d) id/).flatten.first.to_f

        @output = "#{(100 - idle).round(1)}%"
      end

      private

      def sys_cmd
        `top -bn1 | grep 'Cpu(s)'`.chomp
      end

    end

    Cpu = CPU
  end
end
