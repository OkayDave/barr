require 'barr/block'
require 'securerandom'

module Barr
  class Manager

    ERROR_ICON = "%{F#FF0000}\uf071%{F-}"

    attr_reader :count, :blocks

    def initialize
      @count = 0
      @blocks = []
    end

    def add(block)
      block.manager = self
      @blocks << block
    end

    def destroy!
      @blocks.each(&:destroy!)
    end

    def draw
      outputs = { l: [], c: [], r: [] }

      @blocks.each do |block|
        outputs[block.align] << block.draw
      end

      left_blocks = outputs[:l].join ''
      centre_blocks = outputs[:c].join ''
      right_blocks = outputs[:r].join ''

      bar_render = ''
      bar_render << "%{l}#{left_blocks} " if left_blocks.length > 0
      bar_render << "%{c} #{centre_blocks} " if centre_blocks.length > 0
      bar_render << "%{r} #{right_blocks}" if right_blocks.length > 0

      bar_render.gsub! "\n", ''

      system('echo', '-e', bar_render.encode('UTF-8'))
    end

    def run!
      while true
        self.update!
        self.draw
        sleep 1
      end
    end

    def update!
      @blocks.each do |block|
        begin
          block.update! if @count == 0 || (@count % block.interval == 0)
        rescue StandardError => e
          STDERR.puts e.message
          block << ERROR_ICON unless block.output.include?(ERROR_ICON)
          next
        end
      end

      @count += 1
    end

    def id
      @id ||= SecureRandom.uuid
    end
    
    # compatibility methods.
    # alias_method would work here, but for consistency with Block
    # I'll define them this way

    def update; update!; end
    def run; run!; end
    def destroy; destroy!; end
    def add_block(block); add(block); end

  end
end
