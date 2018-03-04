require 'barr/block'

module Barr
  module Blocks
    class Clock < Block
      def initialize(opts = {})
        super
        @format = opts[:format] || '%H:%M %d %b %Y'
      end

      def update!
        @output = Time.now.strftime(@format)
      end
    end
  end
end
