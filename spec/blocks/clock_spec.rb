require 'spec_helper'

Clock = Barr::Blocks::Clock
 
describe Barr::Blocks::Clock do
  describe "#initialize" do
    it "should set default format" do
      expect(Clock.new.format).to eq("%H:%M %m %b %Y")
    end

    it "should allow custom format" do
      expect(Clock.new(format: "%H").format).to eq("%H")
    end
  end

  describe "#update" do
    it "should set the output correctly" do
      @b = Clock.new format: "%Y"
      @b.update
      
      expect(@b.output).to eq(Time.now.year.to_s)
    end
  end
end
