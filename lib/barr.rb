require "barr/version"
require "barr/manager"
require "barr/block"

require 'weather-api'

Dir[File.dirname(__FILE__) + '/barr/blocks/*.rb'].each do |file|
  require file
end

module Barr
end
