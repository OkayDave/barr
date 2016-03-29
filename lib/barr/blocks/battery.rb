module Barr
  module Blocks

    class Battery < Block
      attr_reader :show_remaining
      
      def initialize opts={}
        super
	      @show_remaining = opts[:show_remaining] || true
      end

      def update!
        if @show_remaining
	        @output = battery_remaining
        else
	        @output = battery_no_remaining
        end
      end

      def battery_remaining
        `acpi | cut -d ',' -f 2-3`.chomp
      end
      
      def battery_no_remaining
        `acpi | cut -d ',' -f 2`.chomp
      end
    end
  end
end
