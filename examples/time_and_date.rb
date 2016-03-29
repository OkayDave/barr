#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

time = Barr::Blocks::Clock.new format: '%H:%M', icon: "\uf017", bgcolor: '#114152', fgcolor: '#DAC1DE', align: :l
date = Barr::Blocks::Clock.new format: '%m of %b %Y', bgcolor: '#570B7A', fgcolor: '#FFFFFF', align: :r, icon: "\uf073"

@man.add time
@man.add date

@man.run!
