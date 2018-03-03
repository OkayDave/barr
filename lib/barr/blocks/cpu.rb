
require 'barr/block'

module Barr
  module Blocks
    class CPU < Block
      def initialize(opts = {})
        super
        @format = opts[:format] || '${LOAD}'
      end

      def update!
        op = {}
        op[:load] = load_sys_cmd.to_f.round(2).to_s + '%'
        op[:temp] = (temp_sys_cmd.to_f.round(2) / 1000).to_s + '°'

        @output = format_string_from_hash(op)
      end

      private

      def load_sys_cmd
        `grep 'cpu ' /proc/stat | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}'`
      end

      def temp_sys_cmd
        `cat /sys/class/thermal/thermal_zone0/temp`
      end
    end

    Cpu = CPU
  end
end
