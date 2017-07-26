# coding: utf-8
require 'barr/block'
require 'barr/controller'
require 'barr/blocks/playerctl'
require 'barr/controllers/playerctl'

module Barr
  module Controllers
    class PlayerctlControllerMock < Barr::Controllers::Playerctl
      def document
      end

      def run!
      end

      def update!
        @output ||= {}
        @output[:artist] = "Slayer"
        @output[:title] = "Angel of Death"
        @output[:album] = "Reign in Blood"
      end

    end
  end


  module Blocks
    class PlayerctlBlockMock < Barr::Blocks::Playerctl
      def config
        @controller = Barr::Controllers::PlayerctlControllerMock.new {}
      end
    end
  end
end


