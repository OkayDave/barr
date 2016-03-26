require 'spec_helper'

class HddTest < Barr::Blocks::Hdd
  def sys_cmd
    return "213G 34G 17%"
  end
end

describe Barr::Blocks::Hdd do
  describe "#initialize" do
    it "sets the device" do
      expect(HddTest.new(device: "sdc2").device).to eq("sdc2")
    end

    it "exists" do
      expect(HddTest.new).to be_a_kind_of(Barr::Blocks::Hdd)
      expect(HddTest.new).to be_a_kind_of(Barr::Block)
    end
  end

  describe "#update" do
    it "renders in the correct format" do
      @b = HddTest.new(device: "sdc2")
      @b.update
      
      expect(@b.output).to match(/\d+(G|M) \/ \d+(G|M) \(\d+%\)/)
    end
  end
end
