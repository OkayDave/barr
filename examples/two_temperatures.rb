#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

nyc = Barr::Blocks::BBCWeather.new bgcolor: '#42C7AA',
                                   fgcolor: '#FFF',
                                   icon: 'New York: ',
                                   location: '5128581',
                                   interval: 15

sanfran = Barr::Blocks::BBCWeather.new bgcolor: '#92A084',
                                       fgcolor: '#FFF',
                                       icon: 'San Francisco: ',
                                       location: '5391959',
                                       format: '${TEMPERATURE - ${SUMMARY} - ${WINDSPEED} - ${WINDDIRECTION}',
                                       speed_unit: 'kph',
                                       temp_unit: 'f',
                                       align: :r,
                                       interval: 30

@man.add nyc
@man.add sanfran

@man.run!
