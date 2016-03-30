require 'barr/blocks/battery'

Battery = Barr::Blocks::Battery

RSpec.describe Barr::Blocks::Battery do
  
  describe "#initialize" do

    it "sets default show_remaining" do
      expect(subject.show_remaining).to be(true)
    end
    
  end

  describe "#update" do
    let(:battery_remaining) { "" }
    let(:battery_no_remaining) { "" }
    
    before do
      @remaining = described_class.new show_remaining: true
      @no_remaining = described_class.new
    end

    it "renders remaining output correctly" do
      @remaining.update
      
      expect(@remaining.output).to eq("")
    end

    it "render no remianing output correctly" do
      @no_remaining.update

      expect(@no_remaining.output).to eq("")
    end
  end
end
