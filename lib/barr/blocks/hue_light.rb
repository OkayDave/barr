require 'barr/block'

module Barr
  module Blocks
    class HueLight < Block
      attr_accessor :id

      def initialize(opts = {})
        super

        @id = opts[:id]
        @format = opts[:format] || "${ON} ${OFF}"
      end

      def update!
        @output = format_string_from_hash(base_options, self)
      end

      def additions_for_format(key, option_str)
        agg = []
        text = ""
        options = option_str.split(/(?<!\\),/)

        if options.nil?
          case key.downcase
          when :on
            agg << 'on'
            text = "on"
          when :off
            agg << 'off'
            text = "off"
          end

        else
          options.each do |option|
            option = option.split(/(?<!\\)-/)

            case option[0].downcase
              when 'b'
                agg << "--brightness #{option[1]}"
              when 'h'
                agg << "--hue #{option[1]}"
              when 'a'
                agg << "--alert #{option[1]}"
              when 't'
                text = option[1]
            end
          end

        end

        if text.empty?
          text = key == :off ? "off" : "on"
        end

        if agg.empty?
          agg << key == :off ? "off" : "on"
        end

        return wrap_button("[#{text}]", "#{sys_cmd} #{agg.join(" ")}")
      end

      private

      def base_options
        @base_options ||= {}

        return @base_options unless @base_options.empty?

        @base_options[:on] = wrap_button("[on]", "#{sys_cmd} on")
        @base_options[:off] = wrap_button("[off]", "#{sys_cmd} off")
        return @base_options
      end

      def sys_cmd
        "hue light #{@id}"
      end

    end
  end
end
