module Barr
  module Blocks

    class Rhythmbox < Block
      attr_reader :show_title, :show_buttons, :show_artist

      def initialize opts={}
        super                                                                
        @show_title = opts[:show_title].nil? ? true : opts[:show_title]      
        @show_artist = opts[:show_artist].nil? ? true : opts[:show_artist]
        @show_buttons = opts[:show_buttons].nil? ? true : opts[:show_buttons]
      end

      def update
        op = []

        if @show_artist || @show_title
          if(running?)
            info = sys_cmd("--print-playing").split(" - ")
            if @show_artist && @show_title
              op << info.join(" - ") 
            elsif @show_artist
              op << info[0]
            elsif @show_title
              op << info[1]
            end
          else
            op << "None"
          end
        end

        op << buttons if @show_buttons

        @output = op.join(" ")
        
      end

      def running?
        @running ||= (`pgrep rhythmbox`.length >= 1 ) ? true : false
      end

      def buttons
        @buttons ||= [
          "%{A:rhythmbox-client --previous:}\uf048%{A}",
          "%{A:rhythmbox-client --play-pause:}\uf04b%{A}",     
          "%{A:rhythmbox-client --next:}\uf051%{A}"
        ].join(" ")
      end
      
      def sys_cmd cmd
        `rhythmbox-client #{cmd}`
      end
    end
  end
end
