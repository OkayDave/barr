module Barr
  class Block                                        
    attr_reader :output, :align, :fcolor, :bcolor, :interval, :icon                            

    def align; @align; end                           
    def fcolor; @fcolor; end                         
    def bcolor; @bcolor; end                         
    def color_out; "%{B#{bcolor}}%{F#{fcolor}}"; end 
    def interval; @interval; end                     
    def icon; @icon; end                             
                                                     
    def update; @update = ""; end                            
    def draw; "#{color_out} #{icon} #{@output} "; end
    def destroy; true; end                           
                                                     
    def initialize(opts={})                          
      @align = opts[:align] || :l                    
      @fcolor = opts[:fcolor] || "#FFF"           
      @bcolor = opts[:bcolor] || "#000"           
      @interval = opts[:interval] || 5               
      @icon = opts[:icon] || ""                      
    end                                              
  end                                                
end
