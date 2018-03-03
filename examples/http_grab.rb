#!/usr/bin/env ruby

require 'rubygems'
require 'barr'

@man = Barr::Manager.new

grab = Barr::Blocks::HTTPGrab.new url: 'http://www.bbc.co.uk/news',
                                  icon: 'Top News:',
                                  type: :css,
                                  selector: 'span.most-popular-list-item__headline',
                                  link: true

@man.add grab

@man.run!
