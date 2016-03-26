module Barr
  class Manager
    attr_reader :count, :blocks
    ERROR_ICON = "%{F#FF0000}\uf071"
    def initialize
      @count = 0
      @blocks = []
    end

    def update
      @blocks.each do |block|
        begin
          block.update if @count == 0 || @count%block.interval==0
        rescue StandardError => e
          STDERR.puts e.message
          block.append_output(ERROR_ICON) unless block.output.include?(ERROR_ICON)
          next
        end
      end
      @count += 1
    end

    def draw
      outputs = { l: [], c: [], r: []}

      @blocks.each do |block|
        outputs[block.align]  << block.draw 
      end

      opl = outputs[:l].join(" ")
      opc = outputs[:c].join(" ")
      opr = outputs[:r].join(" ")

      bar_render = ""
      bar_render += "%{l} #{opl}%{F-}%{B-}"  if opl.length > 0
      bar_render += " %{c} #{opc}%{F-}%{B-}" if opl.length > 0
      bar_render += "%{r} #{opr}%{F-}%{B-} " if opr.length > 0
      bar_render.gsub!("\n","")

      system("echo", "-e", bar_render.encode("UTF-8"))
    end

    def destroy
      @blocks.each(&:destroy)
    end

    def add_block block
      @blocks << block
    end
  end
end
