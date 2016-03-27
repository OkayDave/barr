#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new


who = Barr::Blocks::WhoAmI.new align: :r, icon: "\uf007"


i3 = Barr::Blocks::I3.new fcolor: "#FFF",
                          bcolor: "#145266",
                          focus_markers: [">","<"],
                          align: :r,
                          icon: "\uf009"

artist = Barr::Blocks::Rhythmbox.new bcolor: "#466B41",
                                     icon: "\uf028",
                                     show_title: false,
                                     show_buttons: false

song = Barr::Blocks::Rhythmbox.new bcolor: "#1E6614",
                                   show_buttons: false,
                                   show_artist: false

controls = Barr::Blocks::Rhythmbox.new bcolor: "#0A4D02",
                                       show_artist: false,
                                       show_title: false,
                                       align: :r

clock = Barr::Blocks::Clock.new bcolor: "#371E5E",
                                format: "%H:%M - %d %b %Y",
                                icon: "\uf073",
                                align: :r

weather = Barr::Blocks::Temperature.new bcolor: "#4A072B",
                                  align: :l,
                                  location: "2471217",
                                  icon: "\uf0c2 Philadelphia: ",
                                  interval: 1500

cpu = Barr::Blocks::Cpu.new icon: "\uf1fe"

mem = Barr::Blocks::Mem.new bcolor: "#333333"

hdd = Barr::Blocks::Hdd.new bcolor: "#444444", device: "sda2", interval: 300

local = Barr::Blocks::Ip.new bcolor: "#937739", align: :r, icon: "\uf1ce"

# Left
@man.add_block artist
@man.add_block song
@man.add_block weather
@man.add_block cpu
@man.add_block mem
@man.add_block hdd


# Right 
@man.add_block i3
@man.add_block local
@man.add_block who
@man.add_block controls
@man.add_block clock



@man.run
