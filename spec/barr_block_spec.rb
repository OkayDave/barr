require 'spec_helper'

class OutputBlockTest < Barr::Block
  def output= str
    @output = str
  end
end
describe Barr::Block do

  describe '#initialize' do
    it "sets default options" do 
      @b = Barr::Block.new

      expect(@b.align).to eq(:l)
      expect(@b.fcolor).to eq("#FFFFFF")
      expect(@b.bcolor).to eq("#AA4444")
      expect(@b.interval).to eq(5)
      expect(@b.icon).to eq("")
    end

    it "accepts options" do
      opts = {
        align: :r,
        fcolor: "#FFF",
        bcolor: "#000",
        interval: 2,
        icon: "B"
      }

      @b = Barr::Block.new(opts)

      expect(@b.align).to eq(:r)
      expect(@b.fcolor).to eq("#FFF")
      expect(@b.bcolor).to eq("#000")       
      expect(@b.interval).to eq(2)
      expect(@b.icon).to eq("B")
      
    end
  end

  describe "#color_out" do
    before do
      @b = Barr::Block.new
      @b.update
    end
    
    it "calls fcolor and bcolor" do
      expect(@b).to receive(:bcolor).once
      expect(@b).to receive(:fcolor).once

      @b.color_out
    end

    it "is of the correct format" do
      expect(@b.color_out).to eq("%{B#AA4444}%{F#FFFFFF}")
    end
  end

  describe "draw" do
    before do
      @b = OutputBlockTest.new icon: "I"
    end
    it "calls color_out and icon " do
      expect(@b).to receive(:color_out).once
      expect(@b).to receive(:icon).once 

      @b.draw
    end

    it "renders the correct output" do
      @b.output = "test"
      expect(@b.draw).to eq("%{B#AA4444}%{F#FFFFFF} I test ")
    end
  end
end
