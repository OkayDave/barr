require 'barr/manager'

RSpec.describe Barr::Manager do

  let(:block1) { Barr::Block.new interval: 1 }
  let(:block2) { Barr::Block.new interval: 5 }

  before do
    subject.add block1
    subject.add block2
  end

  describe '#update!' do
    it 'calls #update! on each block and respects block interval' do
      expect(block1).to receive(:update!).twice
      expect(block2).to receive(:update!).once

      20.times { subject.update! }
    end

    it 'increments the update count' do
      expect { subject.update! }.to change { subject.count }.by 1
    end
  end

  describe '#draw' do
    it 'calls #draw on each block' do
      expect(block1).to receive(:draw).once
      expect(block2).to receive(:draw).once

      subject.draw
    end
  end

  describe '#add' do
    let(:block) { Barr::Block.new }

    before { subject.add block }

    it 'adds the block to the manager' do
      expect(subject.blocks).to include block
    end
  end

  describe '#destroy!' do
    it 'calls #destroy! on each block' do
      expect(block1).to receive(:destroy!).once
      expect(block2).to receive(:destroy!).once

      subject.destroy!
    end
  end

end
