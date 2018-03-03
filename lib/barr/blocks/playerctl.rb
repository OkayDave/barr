module Barr
  module Blocks
    class Playerctl < Block
      attr_accessor :location

      def initialize(opts = {})
        super
        @format = opts[:format] || '${ARTIST} - ${TITLE}'
        @player = opts[:player] || false
        @btns = nil
      end

      def config
        opts = { id: @player, player: @player }
        @controller = @manager.controller :Playerctl, opts
      end

      def update!
        op = @controller.output.merge buttons
        @output = format_string_from_hash(op).to_s
      end

      def buttons
        if @btns.nil?
          @btns = {
            play_pause: wrap_button("\uf04b", "playerctl #{'-p #{@player} ' if @player}play-pause"),
            next: wrap_button("\uf051", "playerctl #{'-p #{@player} ' if @player}next"),
            previous: wrap_button("\uf048", "playerctl #{'-p #{@player} ' if @player}previous")
          }

          @btns[:buttons] = [
            @btns[:previous],
            @btns[:play_pause],
            @btns[:previous]
          ].join(' ')
        end

        @btns
      end
    end
  end
end
