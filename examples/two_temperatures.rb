#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

nyc = Barr::Blocks::Temperature.new bgcolor: '#42C7AA',
                                    fgcolor: '#FFF',
                                    icon: 'New York: ',
                                    location: '2459115',
                                    interval: 1800

sanfran = Barr::Blocks::Temperature.new bgcolor: '#92A084',
                                        fgcolor: '#FFF',
                                        icon: 'San Francisco: ',
                                        location: '2487956',
                                        align: :r,
                                        interval: 1800

@man.add nyc
@man.add sanfran

@man.run!
