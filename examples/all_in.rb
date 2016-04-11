#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

who = Barr::Blocks::Whoami.new align: :r, icon: "\uf007"

i3 = Barr::Blocks::I3.new(fgcolor: '#FFF',
                          bgcolor: '#145266',
                          focus_markers: %w(> <),
                          align: :r,
                          icon: "\uf009",
                          interval: 0.2)

artist = Barr::Blocks::Rhythmbox.new(bgcolor: '#466B41',
                                     icon: "\uf028",
                                     title: false,
                                     buttons: false)

song = Barr::Blocks::Rhythmbox.new(bgcolor: '#1E6614',
                                   buttons: false,
                                   artist: false)

controls = Barr::Blocks::Rhythmbox.new(bgcolor: '#0A4D02',
                                       artist: false,
                                       title: false,
                                       align: :r)

clock = Barr::Blocks::Clock.new(bgcolor: '#371E5E',
                                format: '%H:%M - %d %b %Y',
                                icon: "\uf073",
                                align: :r)

weather = Barr::Blocks::Temperature.new(bgcolor: '#4A072B',
                                        align: :l,
                                        location: '2471217',
                                        icon: "\uf0c2 Philadelphia: ",
                                        interval: 1500)

cpu = Barr::Blocks::CPU.new icon: "\uf1fe"

mem = Barr::Blocks::Mem.new bgcolor: '#333333'

hdd = Barr::Blocks::HDD.new bgcolor: '#444444', device: 'sdc2', interval: 300

local = Barr::Blocks::IP.new bgcolor: '#937739', align: :r, icon: "\uf1ce"

# Left
@man.add artist
@man.add song
@man.add weather
@man.add cpu
@man.add mem
@man.add hdd

# Right 
@man.add i3
@man.add local
@man.add who
@man.add controls
@man.add clock

@man.run!
