#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

time = Barr::Blocks::Clock.new format: "%H:%M", icon: "\uf017", bcolor: "#114152", fcolor: "#DAC1DE", align: :l
date = Barr::Blocks::Clock.new format: "%m of %b %Y", bcolor: "#570B7A", fcolor: "#FFFFFF", align: :r, icon: "\uf073"

@man.add_block time
@man.add_block date

@man.run
