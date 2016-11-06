module Barr
  module Blocks
    class HTTPGrab < Block
      attr_accessor :url, :type, :selector, :link

      def initialize opts={}
        super
        @url = opts[:url]
        @type = opts[:type] || :css
        @selector = opts[:selector]
        @link = !!opts[:link]
      end

      def config
        opts = {url: @url, type: @type, selector: @selector}
        @controller = @manager.controller :HTTPGrab, opts
      end

      def update!
        @output = @controller.output[:text]
        @output = "%{A:barr_open_url #{@url.gsub("://"," ").gsub("/","\/")}:}#{@output}%{A}" if @link
      end
    end
  end
end
