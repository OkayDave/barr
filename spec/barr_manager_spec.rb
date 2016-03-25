require 'spec_helper'

describe Barr::Manager do

  before do
    
    @b1 = Barr::Block.new interval: 1
    @b2 = Barr::Block.new interval: 5
    @man = Barr::Manager.new
    @man.add_block @b1
    @man.add_block @b2
  end

  describe '#initialize' do
    before { @new_man = Barr::Manager.new }
    it "sets @block" do
      expect(@new_man.blocks).to eql([])
    end

    it "sets @count" do
      expect(@new_man.count).to be(0)
    end
  end

  describe '#update' do
    it "calls #update on each block and respects block interval" do
      expect(@b1).to receive(:update).twice
      expect(@b2).to receive(:update).once

      @man.update
      @man.update
    end

    it "increments @count" do
      @man.update
      @man.update
      expect(@man.count).to be(2)
    end
  end

  describe '#draw' do
    it "calls #draw on each block" do
      expect(@b1).to receive(:draw).once
      expect(@b2).to receive(:draw).once

      @man.draw
    end

  end

  describe '#add_block' do
    it "adds block" do
      nb = Barr::Block.new 
      @man.add_block nb

      expect(@man.blocks).to include(nb)
    end
  end

  describe '#destroy' do
    it "calls #destroy on each block" do
      expect(@b1).to receive(:destroy).once
      expect(@b2).to receive(:destroy).once

      @man.destroy
    end
  end
end
