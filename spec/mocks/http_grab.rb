
require 'barr/block'
require 'barr/controller'
require 'barr/blocks/http_grab'
require 'barr/controllers/http_grab'
require 'nokogiri'

module Barr
  module Controllers
    class HTTPGrabControllerMock < Barr::Controllers::HTTPGrab
      def document; end

      def run!; end

      def update!
        @output ||= {}
        @output[:text] = 'Top news article!'
      end
    end
  end

  module Blocks
    class HTTPGrabBlockMock < Barr::Blocks::HTTPGrab
      def config
        opts = { id: 'http://fakedomain.com/url', type: :css, selector: 'span.mocked_class', link: true }

        @controller = Barr::Controllers::HTTPGrabControllerMock.new opts
      end
    end
  end
end
