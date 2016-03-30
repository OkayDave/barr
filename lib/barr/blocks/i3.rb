require 'i3ipc'
require 'barr/block'

module Barr
  module Blocks
    class I3 < Block

      attr_reader :focus_markers, :i3, :workspaces

      def initialize(opts = {})
        super

        @focus_markers = opts[:focus_markers] || %w(> <)
        @invert_focus_colors = opts[:invert_focus_colors] || false 
        @i3 = i3_connection
      end

      def update!
        @workspaces = @i3.workspaces.map do |wsp|
          if wsp.focused
            "#{invert_colors if @invert_focus_colors}#{l_marker}#{wsp.name}#{r_marker}#{invert_colors if @invert_focus_colors}"
          else
            "%{A:barr_i3ipc \"workspace #{wsp.name.gsub(":","\\:")}\":} #{wsp.name} %{A}"
          end
        end

        @output = @workspaces.join('')
      rescue => e
        if e.message.match(/broken pipe/i)
          @i3 = i3_connection
        else
          raise
        end
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
