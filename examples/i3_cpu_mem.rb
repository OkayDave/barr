#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

i3 = Barr::Blocks::I3.new icon: "\uf108", bcolor: "#114152", fcolor: "#DAC1DE", align: :l, focus_markers: ["\uf0a4",""]
cpu = Barr::Blocks::Cpu.new icon: "\uf108 CPU:", bcolor: "#491A5E", align: :r
mem = Barr::Blocks::Mem.new icon: "RAM:", align: :r, bcolor: "#2F113D"
disk = Barr::Blocks::Hdd.new icon: "SSD:", align: :r, bcolor: "#380B4D", device: "sda2"

@man.add_block i3
@man.add_block cpu
@man.add_block mem
@man.add_block disk

@man.run
