module Barr
  class Block
    attr_reader :align, :bgcolor, :fgcolor, :icon, :interval, :output

    def initialize(opts = {})
      @align = opts[:align] || :l
      @bgcolor = opts[:bgcolor] || '-'
      @fgcolor = opts[:fgcolor] || '-'
      @icon = opts[:icon] || ''
      @interval = opts[:interval] || 5

      @output = ''
    end

    def <<(str)
      @output << str
    end

    def color_out
      "%{B#{bgcolor}}%{F#{fgcolor}}"
    end

    def draw
      "#{color_out} #{icon} #{@output} "
    end

    def destroy
    end

    def update
    end
  end
end
