module Barr
  class Controller
    attr_accessor :file, :output, :retry_at, :interval, :id 
    
    def initialize opts={}
      @id = opts[:id]
      @interval = opts[:interval] || 5
      @interval = (@interval * 10).round
      @output = {}
    end

    def run!
    end

    def update!
      
    end

    def file
      @file ||= File.new(filename, "w" )
    end

    def filename
      @filename ||= "/tmp/barr-#{self.class.name}-#{@id}".gsub("::","-").downcase
    end

    def close_file
      @file.close
      @file.unlink
      @file = nil
    end

    def destroy!
      close_file 
    end

  end
end
