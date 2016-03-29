require 'barr/block'

module Barr
  module Blocks
    class Whoami < Block

      def initialize(opts = {})
        super
      end

      def update!
        @output = sys_cmd
      end

      private

      def sys_cmd
        `whoami`.chomp
      end

    end

    WhoAmI = Whoami
  end
end
