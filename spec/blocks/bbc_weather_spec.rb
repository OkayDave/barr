require 'spec_helper'
require './spec/mocks/bbc_weather'

RSpec.describe Barr::Blocks::BBCWeatherBlockMock do

  describe '#initialize' do
    it "sets default format" do
      expect(subject.format).to eq("${TEMPERATURE} - ${SUMMARY}")
    end
  end

  describe 'config' do
    it "sets the controller" do
      subject.config
      expect(subject.controller).to be_a(Barr::Controllers::BBCWeatherControllerMock)
    end
  end

  describe 'update' do
    it "sets the output correctly" do
      subject.location = "123456"
      subject.config
      subject.controller.update!
      subject.update!
      expect(subject.output).to eq("%{A:barr_open_url http www.bbc.co.uk/weather/123456:}17 C - Nice outside%{A}")
    end
  end

end
