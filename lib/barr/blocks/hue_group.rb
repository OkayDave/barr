require 'barr/block'

module Barr
  module Blocks
    class HueGroup < Barr::Blocks::HueLight
      attr_accessor :id

      private

      def sys_cmd
        "hue group #{@id}"
      end
    end
  end
end
