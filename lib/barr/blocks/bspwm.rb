require 'barr/block'
require 'json'

module Barr
  module Blocks

    class Bspwm < Block

      attr_reader :monitor, :tree, :focus_markers
      attr_accessor :invert_focus_colors
      def initialize opts={}
        super
        @monitor = opts[:monitor] || first_monitor
        @invert_focus_colors = opts[:invert_focus_colors] || false
        @focus_markers = opts[:focus_markers] || %w(> <)
      end

      def update!
        @tree = nil
        op = []
        focused = ""
        
        bsp_tree["monitors"].each do |monitor|
          next if monitor["name"] != @monitor
          focused = monitor["focusedDesktopName"]
          monitor["desktops"].each do |desktop|
            if desktop["name"] == focused
              op << focused_desktop(desktop)
            else
              op << unfocused_desktop(desktop)
            end
          end
          
        end

        @output = op.join(" ")
      end

      def bsp_tree
        @tree ||= JSON.parse(sys_cmd)
      end

      def focused_desktop desktop
        op = ""
        op += invert_colors if @invert_focus_colors
        op += @focus_markers[0] + " "
        op += desktop["name"]
        op += " " + @focus_markers[1] 
        op += invert_colors if @invert_focus_colors

        op
      end

      def unfocused_desktop desktop
        op = ""
        op += "%{A:bspc desktop -f #{desktop["name"].gsub(":","\:")}:} "
        op += "#{desktop["name"]}"
        op += " %{A}"

        return op
      end
      
      def first_monitor
        bsp_tree["primaryMonitorName"]
      end

      def sys_cmd
        `bspc wm -d`.chomp
      end
    end
  end
end
