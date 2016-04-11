# coding: utf-8
require 'barr/block'
require 'dbus'

module Barr
  module Blocks
    class Spotify < Block
      DBUS_PLAY = 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause'.freeze
      DBUS_NEXT = 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next'.freeze
      DBUS_PREV = 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous'.freeze

      attr_reader :view_opts, :spotify_iface

      def initialize(opts = {})
        super

        @view_opts = {
          artist:   opts[:artist].nil? || opts[:artist],
          buttons: opts[:buttons].nil? || opts[:buttons],
          title: opts[:title].nil? || opts[:title]
        }
        @spotify_iface = dbus_connection
      end

      def update!
        op = []

        if @view_opts[:artist] || @view_opts[:title]
          if(running?)
            info = sys_cmd[:foo]

            if @view_opts[:artist] && @view_opts[:title]
              op << "#{info[:artist]} - #{info[:title]}"
            elsif @view_opts[:artist]
              op << info[:artist]
            elsif @view_opts[:title]
              op << info[:title]
            end
          else
            op << 'None'
          end
        end

        op << buttons if @view_opts[:buttons]

        @output = op.join(' ')

      end

      def running?
        `pgrep spotify`.chomp.length != 0
      end

      def buttons
        [
          "%{A:#{DBUS_PREV}:}\uf048%{A}",
          "%{A:#{DBUS_PLAY}:}\uf04b%{A}",
          "%{A:#{DBUS_NEXT}:}\uf051%{A}"
        ].join(' ').freeze
      end

      def dbus_connection
        begin
          spotify_service = DBus.session_bus['org.mpris.MediaPlayer2.spotify']
          spotify_player = spotify_service.object '/org/mpris/MediaPlayer2'
          spotify_player.introspect
        rescue DBus::Error
          # This should only happen when testing and Spotify is not running,
          # because DBus cannot find a service file that provides
          # org.mpris.MediaPlayer2.spotify. This will not be an issue with
          # typical usage as long as #running? is checked before using this
          # method or #sys_cmd.
          return nil
        else
          return spotify_player['org.mpris.MediaPlayer2.Player']
        end
      end

      private

      def sys_cmd
        dbus_meta = @spotify_iface['Metadata']
        Hash.new title: dbus_meta['xesam:title'],
                 artist: dbus_meta['xesam:artist'].join(', '),
                 album: dbus_meta['xesam:album']
      end
    end
  end
end
