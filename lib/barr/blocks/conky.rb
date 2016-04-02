require 'barr/block'

module Barr
  module Blocks

    class Conky < Block

      def initialize opts={}
        super
        @text = opts[:text]

        write_template
        spawn_conky
      end

      def update!
        @output = sys_cmd
      end

      def sys_cmd
        `tail -n1 #{@filename_output}`.chomp
      end

      def write_template
        @conky_template = " 
          out_to_x no 
          out_to_console yes
          own_window no 
          update_interval #{@interval.to_f.to_s}
          TEXT
          #{@text} 
        ".gsub(/^\s+/, '').chomp!

        @filename_template = tmp_filename+"-conky"
        @filename_output = tmp_filename+"-output"

        STDERR.puts "@conky_template: "
        STDERR.puts @conky_template
        File.open(@filename_template, "w") { |f| f.write(@conky_template) }
      end

      def spawn_conky
        @process = spawn("conky -c #{@filename_template} > #{@filename_output}")
        Process.detach(@process)
      end

      def destroy!
        Process.kill(@process)
      end
      
    end
  end
end
