require 'barr/block'

module Barr
  module Blocks
    class Conky < Block
      attr_reader :text
      def initialize(opts = {})
        super
        @text = opts[:text]

        write_template
        spawn_conky
      end

      def update!
        @output = sys_cmd
      end

      def sys_cmd
        `tail -n1 #{@filename_output}`.chomp.tr('#', "\u2588")
      end

      def write_template
        @conky_template = "
          out_to_x no
          out_to_console yes
          own_window no
          update_interval #{@interval.to_f}
          TEXT
          #{@text}
        ".gsub(/^\s+/, '').chomp!

        @filename_template = tmp_filename + '-conky'
        @filename_output = tmp_filename + '-output'

        STDERR.puts '@conky_template: '
        STDERR.puts @conky_template
        File.open(@filename_template, 'w') { |f| f.write(@conky_template) }
      end

      def spawn_conky
        @process = spawn("conky -c #{@filename_template} > #{@filename_output}")
        Process.detach(@process)
      end

      def destroy!
        `rm #{@filename_template}`
        `rm #{@filename_output}`
      end
    end
  end
end
