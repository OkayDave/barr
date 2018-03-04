require 'barr/block'

module Barr
  module Blocks
    class Separator < Block
      def initialize(opts = {})
        super
        @symbol = opts[:symbol] || '|'
      end

      def update!
        @output = @symbol
      end
    end
  end
end
