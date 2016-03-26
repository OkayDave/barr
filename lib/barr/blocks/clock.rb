module Barr
  module Blocks
    class Clock < Block
      attr_reader :format

      def initialize opts={}
        super
        @format = opts[:format] || "%H:%M %m %b %Y"
      end

      def update
        @output = Time.now.strftime(@format)
      end
    end
  end
end
