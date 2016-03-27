module Barr
  class Block
    attr_reader :align, :bgcolor, :data, :fgcolor, :icon, :interval

    def initialize(opts = {})
      @align = opts[:align] || :l
      @bgcolor = opts[:bgcolor] || '-'
      @fgcolor = opts[:fgcolor] || '-'
      @icon = opts[:icon] || ''
      @interval = opts[:interval] || 5

      @data = ''
    end

    def <<(str)
      @data << str
    end

    def colors
      "%{B#{bgcolor}}%{F#{fgcolor}}"
    end

    def draw
      "#{colors} #{icon} #{@data} #{reset_colors}"
    end

    def destroy!
    end

    def update!
    end

    private

    def reset_colors
      '%{F-}%{B-}'
    end

  end
end
