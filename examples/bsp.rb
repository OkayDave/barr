#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

bsp = Barr::Blocks::Bspwm.new icon: "\uf108", bgcolor: '#114152', fgcolor: '#DAC1DE', align: :l, focus_markers: ['',''], invert_focus_colors: true, interval: 1

bsp_df = Barr::Blocks::Bspwm.new align: :r, interval: 1

@man.add bsp
@man.add bsp_df

@man.run!
