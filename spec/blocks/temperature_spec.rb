# coding: utf-8
require 'spec_helper'

class Temperature < Barr::Blocks::Temperature
  def weather_data
    WeatherDataTest.new
  end
end

class WeatherDataTest
  def condition
    Class.new do
      def temp
        return "100"
      end

      def text
        return "Nice day"
      end
    end.new
  end
end

describe Barr::Blocks::Temperature do
  it "exists" do
    expect(Temperature.new).to be_a_kind_of(Barr::Blocks::Temperature)
    expect(Temperature.new).to be_a_kind_of(Barr::Block)
  end

  describe '#initialize' do
    it "accepts location option" do
      expect(Temperature.new(location: "12723").location).to eq("12723") 
    end

    it "accepts unit option" do
      expect(Temperature.new(unit: "F").unit).to eq("F")
    end

    it "sets default unit" do
      expect(Temperature.new.unit).to eq("C")
    end
  end

  describe "update" do
    it "renders in the correct format" do
      @b = Temperature.new location: "12723"
      @b.update

      expect(@b.output).to match(/%\{A\:xdg-open weather.yahoo.com\/country\/state\/city-12723\/:\}\d+°(C|F) (\w+| )+%{A}/)
    end
  end
end
