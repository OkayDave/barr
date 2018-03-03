#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

light = Barr::Blocks::HueLight.new id: '6',
                                   icon: "\uf0eb",
                                   format: '${OFF:T-Turn Off} ${ON} ${ON:B-50,T-Dim 25%,H-34332} ${ON:A-lselect,T-Alert!,H-65535}'

group = Barr::Blocks::HueGroup.new id: '3',
                                   icon: "\uf1ad",
                                   format: '${OFF:T-Turn Off} ${ON:H-1,T-Turn On}'

@man.add light
@man.add group

@man.run!
