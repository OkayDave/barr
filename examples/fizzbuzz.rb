#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

class FizzBuzz < Barr::Block
  def initialize(opts = {})
    super
    @count = opts[:count] || 0
  end

  def update!
    @count += 1

    @data = if (@count % 3 == 0) && (@count % 5 == 0)
              'FizzBuzz'
            elsif @count % 3 == 0
              'Fizz'
            elsif @count % 5 == 0
              'Buzz'
            else
              @count.to_s
            end 
  end
end


clock = Barr::Blocks::Clock.new align: :r
counter = FizzBuzz.new align: :l, bgcolor: '#8CB8FF', fgcolor: '#333333', icon: "\uf1ec", interval: 1

@man = Barr::Manager.new

@man.add clock
@man.add counter

@man.run!
