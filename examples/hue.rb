#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

light = Barr::Blocks::HueLight.new id: "5",
                                   icon: "\uf0eb",
                                   format: "${OFF:T-Turn Off} ${ON} ${ON:B-50,T-Dim 25%} ${ON:A-lselect,T-Alert!}"

@man.add light

@man.run!
