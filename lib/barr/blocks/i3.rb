require 'i3ipc'
require 'barr/block'

module Barr
  module Blocks
    class I3 < Block

      attr_reader :focus_markers, :i3, :workspaces

      def initialize(opts = {})
        super

        @focus_markers = opts[:focus_markers] || %w(> <)
        @i3 = i3_connection
      end

      def update!
        @workspaces = @i3.workspaces.map do |wsp|
          if wsp.focused
            "#{l_marker}#{wsp.name}#{r_marker}"
          else
            "%{A:barr_i3ipc \"workspace #{wsp.name.gsub(":","\\:")}\":} #{wsp.name} %{A}"
          end
        end

        @output = @workspaces.join('')
      end

      def destroy!
        @i3.close
      end

      def i3_connection
        I3Ipc::Connection.new
      end

      private

      def l_marker
        @focus_markers[0]
      end

      def r_marker
        @focus_markers[1]
      end

    end
  end
end
