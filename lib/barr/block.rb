module Barr
  class Block
    attr_accessor :align, :bgcolor, :fgcolor, :icon, :interval, :manager, :controller, :format, :output

    def initialize(opts = {})
      reassign_deprecated_option opts, :fcolor, :fgcolor
      reassign_deprecated_option opts, :bcolor, :bgcolor
      @align = opts[:align] || :l
      @bgcolor = opts[:bgcolor] || '-'
      @fgcolor = opts[:fgcolor] || '-'
      @icon = opts[:icon] || ''
      @interval = opts[:interval] || 5
      @interval = (@interval * 10).round

      @output = ''
    end

    def config
      # called by manager
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
      @tmp_filename ||= "/tmp/barr-#{SecureRandom.uuid}-#{self.class.name.gsub(/::/, "-")}-#{SecureRandom.urlsafe_base64}"
      return @tmp_filename
    end

    def substitue_variables string_format, subs
      reg = /\$\{\w+\}/i
      new_string = string_format
      matches = string_format.scan reg
      matches.each do |match|
        keyword = match.scan(/\w+/i).first.downcase

        if subs.has_key? keyword
          sub = keyword
        else
          sub = ""
        end

        new_string.gsub!(match, sub)
      end

      return new_string
    end

    def format_string_from_hash(hash)
      formatted = @format.clone 
      matches = @format.scan(/([\$][\{](\w+)[\}])/)

      matches.each do |match|
        key =  match[1].downcase.to_sym
        if hash.has_key? key
          sub = hash[key]
        else
          sub = ""
        end

        formatted.gsub! match[0], sub
      end

      return formatted
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
