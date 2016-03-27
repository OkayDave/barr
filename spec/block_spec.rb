require 'spec_helper'
require 'barr/block'

RSpec.describe Barr::Block do

  describe '#initialize' do
    subject { described_class.new }

    context 'defaults' do
      it 'has a default alignment' do
        expect(subject.align).to eq :l
      end

      it 'has a default bgcolor' do
        expect(subject.bgcolor).to eq '-'
      end

      it 'has no default data' do
        expect(subject.data).to eq ''
      end

      it 'has a default fgcolor' do
        expect(subject.fgcolor).to eq '-'
      end

      it 'has a default icon' do
        expect(subject.icon).to eq ''
      end

      it 'has a default interval' do
        expect(subject.interval).to eq 5
      end
    end
  end

  describe '#<<' do
    subject { described_class.new }

    it 'appends to the block data' do
      expect { subject << 'test' }.to change { subject.data }.from('').to('test')
    end
  end

  describe '#colors' do
    subject { described_class.new bgcolor: '#000', fgcolor: '#FFF' }

    it 'sends color instructions' do
      expect(subject.colors).to eq('%{B#000}%{F#FFF}')
    end
  end

  describe '#draw' do
    subject { described_class.new icon: 'I', bgcolor: '#000' }

    before { subject << 'test' }

    it 'renders correctly' do
      expect(subject.draw).to eq '%{B#000}%{F-} I test %{F-}%{B-}'
    end
  end

end
