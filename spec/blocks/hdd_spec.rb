require 'spec_helper'

Hdd = Barr::Blocks::Hdd

describe Hdd do
  describe "#initialize" do
    it "sets the device" do
      expect(Hdd.new(device: "sdc2").device).to eq("sdc2")
    end

    it "exists" do
      expect(Hdd.new).to be_a_kind_of(Barr::Blocks::Hdd)
      expect(Hdd.new).to be_a_kind_of(Barr::Block)
    end
  end

  describe "#update" do
    it "renders in the correct format" do
      @b = Hdd.new(device: "sdc2")
      @b.update
      
      expect(@b.output).to match(/\d+(G|M) \/ \d+(G|M) \(\d+%\)/)
    end
  end
end
