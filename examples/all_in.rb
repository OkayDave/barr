#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

who = Barr::Blocks::Whoami.new align: :r, icon: "\uf007"

i3 = Barr::Blocks::I3.new(fgcolor: '#FFF',
                          bgcolor: '#145266',
                          focus_markers: [' ', ' '],
                          invert_focus_colors: true,
                          align: :r,
                          icon: "\uf009",
                          interval: 0.1)

music = Barr::Blocks::Playerctl.new(bgcolor: '#1E6614',
                                    format: "${ARTIST} - ${TITLE}",
                                    interval: 2)

controls = Barr::Blocks::Playerctl.new(bgcolor: '#0A4D02',
                                       format: "${BUTTONS}",
                                       align: :r)

clock = Barr::Blocks::Clock.new(bgcolor: '#371E5E',
                                format: '%H:%M - %d %b %Y',
                                icon: "\uf073",
                                align: :r)

weather = Barr::Blocks::BBCWeather.new(bgcolor: '#4A072B',
                                       align: :l,
                                       location: 'b17',
                                       icon: "\uf0c2 Birmingham: ",
                                       interval: 1500)

cpu = Barr::Blocks::CPU.new icon: "\uf1fe", format: '${LOAD}% ${TEMP}'

mem = Barr::Blocks::Mem.new bgcolor: '#333333'

hdd = Barr::Blocks::HDD.new bgcolor: '#444444', device: 'sdc2', interval: 300

local = Barr::Blocks::IP.new bgcolor: '#937739', align: :r, icon: "\uf1ce"

office_lights = Barr::Blocks::HueGroup.new id: '12',
                                           icon: "\uf1ad",
                                           format: '${OFF} ${ON:H-1,H-65535,B-255} ${ON:B-120,T-dim}',
                                           align: :r,
                                           bgcolor: '#0c1e3a',
                                           fgcolor: '#EEEEEE'
# Left
@man.add music
@man.add weather
@man.add cpu
@man.add mem
@man.add hdd

# Right
@man.add office_lights
@man.add i3
@man.add local
@man.add who
@man.add controls
@man.add clock

@man.run!
