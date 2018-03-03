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

    @output = if (@count % 3).zero? && (@count % 5).zero?
                'FizzBuzz'
              elsif (@count % 3).zero?
                'Fizz'
              elsif (@count % 5).zero?
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
