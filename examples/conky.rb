#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

netspeed = Barr::Blocks::Conky.new text: "${downspeedf enp3s0} ${upspeedf enp3s0}", align: :l
cpu = Barr::Blocks::Conky.new text: "${cpubar}", align: :c
swap = Barr::Blocks::Conky.new text: "${swap}", align: :r

@man.add netspeed
@man.add cpu
@man.add swap

@man.run!
