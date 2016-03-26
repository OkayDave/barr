module Barr
  module Blocks

    class RhythmBox < Block
      attr_reader :show_title, :show_buttons

      def initialize opts={}
        
      end


      def sys_cmd cmd
        `rhythmbox-client #{cmd}`
      end
    end
  end
end
