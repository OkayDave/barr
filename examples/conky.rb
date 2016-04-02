#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

netspeed = Barr::Blocks::Conky.new text: "${downspeedf enp3s0} ${upspeedf enp3s0}", align: :l, interval: 1
cpu = Barr::Blocks::Conky.new text: "${cpubar}", align: :c, interval: 1
swap = Barr::Blocks::Conky.new text: "${swap}", align: :r, interval: 1

@man.add netspeed
@man.add cpu
@man.add swap

@man.run!
