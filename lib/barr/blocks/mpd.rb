require 'barr/block'

module Barr
  module Blocks
    class MPD < Block
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
          if running?
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
        if !`pgrep mopidy`.chomp.empty?
          true
        else
          !`pgrep mpd`.chomp.empty?
        end
      end

      def buttons
        [
          "%{A:mpc prev:}\uf048%{A}",
          "%{A:mpc toggle:}\uf04b%{A}",
          "%{A:mpc next:}\uf051%{A}"
        ].join(' ').freeze
      end

      private

      def sys_cmd
        `mpc | sed -n 1p`.chomp
      end
    end
  end
end
