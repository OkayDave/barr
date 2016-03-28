module Barr
  class Block
    attr_reader :align, :bgcolor, :fgcolor, :icon, :interval, :output

    def initialize(opts = {})
      reassign_deprecated_option opts, :fcolor, :fgcolor
      reassign_deprecated_option opts, :bcolor, :bgcolor
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

    def colors
      "%{B#{bgcolor}}%{F#{fgcolor}}"
    end

    def draw
      "#{colors} #{icon} #{@output} #{reset_colors}"
    end

    def destroy!
    end
    
    def update!
    end

    # Backwards compatiblity methods.
    # can't use alias/alias_method as they don't
    # trickle down to subclasses 
    def update; update!; end
    def destroy; destroy!; end
    
    def reassign_deprecated_option opts, old, new
      if opts[new].nil? && !opts[old].nil?
        STDERR.puts "Warning: the '#{old}' option will soon be deprecated in favour of '#{new}'. \n Please update your script."
        opts[new] = opts[old]
      end
    end

    private

    def reset_colors
      '%{F-}%{B-}'
    end

  end
end
