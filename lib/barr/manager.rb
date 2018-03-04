require 'barr/block'
require 'securerandom'

module Barr
  class Manager
    ERROR_ICON = "%{F#FF0000}\uf071%{F-}".freeze

    attr_reader :count, :blocks

    def initialize
      @count = 0
      @blocks = []
      @controllers = {}
    end

    def add(block)
      block.manager = self
      @blocks << block
      block.config
    end

    def destroy!
      @blocks.each(&:destroy!)
      @controllers.each_value(&:destroy!)
    end

    def controller(type, opts = {})
      opts[:id] ||= ''
      key = "#{type}_#{opts[:id]}"

      return @controllers[key] if @controllers[key]

      controller = Object.const_get('Barr::Controllers::' + type.to_s).new(opts)
      @controllers[key] = controller
      controller.run!

      controller
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
      bar_render << "%{l}#{left_blocks} " unless left_blocks.empty?
      bar_render << "%{c} #{centre_blocks} " unless centre_blocks.empty?
      bar_render << "%{r} #{right_blocks}" unless right_blocks.empty?

      bar_render.delete! "\n"

      system('echo', '-e', bar_render.encode('UTF-8'))
    end

    def run!
      loop do
        update!
        draw
        sleep 0.1
      end
    end

    def update!
      @blocks.each do |block|
        begin
          block.update! if @count.zero? || (@count % block.interval).zero?
        rescue StandardError => e
          STDERR.puts 'block: ' + e.class.name
          STDERR.puts e.message
          STDERR.puts e.backtrace
          block << ERROR_ICON unless block.output.include?(ERROR_ICON)
          next
        end
      end

      @controllers.each_value do |controller|
        begin
          controller.update! if @count == 1 || (@count % controller.interval).zero?
        rescue StandardError => e
          STDERR.puts 'controller: ' + e.class.name
          STDERR.puts e.message
          STDERR.puts e.backtrace
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

    def update
      update!
    end

    def run
      run!
    end

    def destroy
      destroy!
    end

    def add_block(block)
      add(block)
    end
  end
end
