require 'barr/block'

module Barr
  module Blocks
    class Rhythmbox < Block
      attr_reader :view_opts

      def initialize(opts = {})
        super
        reassign_deprecated_option opts, :show_artist, :artist
        reassign_deprecated_option opts, :show_title, :title
        reassign_deprecated_option opts, :show_buttons, :buttons

        @view_opts = {
          artist:   opts[:artist].nil? || opts[:artist],
          buttons: opts[:buttons].nil? || opts[:buttons],
          title: opts[:title].nil? || opts[:title]
        }
      end

      def update!
        op = []

        if @view_opts[:artist] || @view_opts[:title]
          if(running?)
            info = sys_cmd.split(' - ')

            if @view_opts[:artist] && @view_opts[:title]
              op << info.join(' - ')
            elsif @view_opts[:artist]
              op << info[0]
            elsif @view_opts[:title]
              op << info[1]
            end
          else
            op << 'None'
          end
        end

        op << buttons if @view_opts[:buttons]

        @output = op.join(' ')

      end

      def running?
        `pgrep rhythmbox`.chomp.length != 0
      end

      def buttons
        [
          "%{A:rhythmbox-client --previous:}\uf048%{A}",
          "%{A:rhythmbox-client --play-pause:}\uf04b%{A}",
          "%{A:rhythmbox-client --next:}\uf051%{A}"
        ].join(' ').freeze
      end

      private

      def sys_cmd
        `rhythmbox-client --print-playing`.chomp
      end
    end
  end
end
