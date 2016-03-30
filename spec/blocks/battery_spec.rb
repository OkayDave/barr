require 'barr/blocks/battery'

RSpec.describe Barr::Blocks::Battery do
  
  describe "#initialize" do

    it "sets default show_remaining" do
      expect(subject.show_remaining).to be(true)
    end
    
  end

  describe "#update" do
    let(:battery_remaining) { "96%, 03:17:39 remaining" }
    let(:battery_no_remaining) { "96%" }
    
    before do
      @remaining = described_class.new show_remaining: true
      @no_remaining = described_class.new show_remaining: false

      allow(@remaining).to receive(:battery_remaining).and_return(battery_remaining)
      allow(@no_remaining).to receive(:battery_no_remaining).and_return(battery_no_remaining)     
    end

    it "renders remaining output correctly" do
      @remaining.update
      
      expect(@remaining.output).to eq("96%, 03:17:39 remaining")
    end

    it "render no remaining output correctly" do
      @no_remaining.update

      expect(@no_remaining.output).to eq("96%")
    end
  end
end
