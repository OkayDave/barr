require 'barr/block'

module Barr
  module Blocks
    class FreeText < Block
      attr_accessor :text

      def initialize(opts = {})
        super
        @text = opts[:text] || ''
      end

      def update!
        @output = @text
      end
    end
  end
end
