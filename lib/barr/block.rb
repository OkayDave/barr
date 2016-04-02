module Barr
  class Block
    attr_reader :align, :bgcolor, :fgcolor, :icon, :interval, :output
    attr_accessor :manager

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

    def tmp_filename
      @tmp_filename ||= "/tmp/#{SecureRandom.uuid}-#{self.class.name.gsub(/::/, "-")}-#{SecureRandom.urlsafe_base64}"
      return @tmp_filename
    end

    # Backwards compatiblity methods.
    # can't use alias/alias_method as they don't
    # trickle down to subclasses 
    def update; update!; end
    def destroy; destroy!; end
    
    def reassign_deprecated_option opts, old, new
      if opts[new].nil? && !opts[old].nil?
        STDERR.puts "Warning: #{self.class.name}'s '#{old}' option will soon be deprecated in favour of '#{new}'. \n Please update your script."
        opts[new] = opts[old]
      end
    end

    private

    def reset_colors
      '%{F-}%{B-}'
    end

    def invert_colors
      '%{R}'
    end

  end
end
