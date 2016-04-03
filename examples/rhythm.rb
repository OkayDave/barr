#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

artist = Barr::Blocks::Rhythmbox.new align: :l, title: false, buttons: false, bgcolor: '#266623', icon: "\uf028", width: 10, interval: 0.5

title = Barr::Blocks::Rhythmbox.new align: :l, artist: false, buttons: false, bgcolor: '#0D450A', width: 10, interval: 0.5

btns = Barr::Blocks::Rhythmbox.new align: :r, artist: false, title: false, bgcolor: '#033B00', interval: 10000

@man.add artist
@man.add title
@man.add btns

@man.run!
