#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

i3 = Barr::Blocks::I3.new icon: "\uf108", bgcolor: '#114152', fgcolor: '#DAC1DE', align: :l, focus_markers: ["| \uf0a4", ' |'], invert_focus_colors: true, interval: 0.2

cpu = Barr::Blocks::CPU.new icon: "\uf108 CPU:", bgcolor: '#491A5E', align: :r, format: '${LOAD}'

mem = Barr::Blocks::Mem.new icon: 'RAM:', align: :r, bgcolor: '#2F113D'

disk = Barr::Blocks::HDD.new icon: 'SSD:', align: :r, bgcolor: '#380B4D', device: 'sda2'

@man.add i3
@man.add cpu
@man.add mem
@man.add disk

@man.run!
