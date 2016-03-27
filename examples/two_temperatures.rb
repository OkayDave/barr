#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

nyc = Barr::Blocks::Temperature.new bcolor: "#42C7AA",
                                    fcolor: "#FFF",
                                    icon: "New York: ",
                                    location: "2459115",
                                    interval: 1800

sanfran = Barr::Blocks::Temperature.new bcolor: "#92A084",
                                        fcolor: "#FFF",
                                        icon: "San Francisco: ",
                                        location: "2487956",
                                        align: :r,
                                        interval: 1800

@man.add_block nyc
@man.add_block sanfran

@man.run
