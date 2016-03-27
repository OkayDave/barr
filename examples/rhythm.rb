#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

artist = Barr::Blocks::Rhythmbox.new align: :l, show_title: false, show_buttons: false, bcolor: "#266623", icon: "\uf028"
title = Barr::Blocks::Rhythmbox.new align: :l, show_artist: false, show_buttons: false, bcolor: "#0D450A"
btns = Barr::Blocks::Rhythmbox.new align: :r, show_artist: false, show_title: false, bcolor: "#033B00", interval: 10000



@man.add_block artist
@man.add_block title
@man.add_block btns

@man.run

