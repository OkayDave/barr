require 'spec_helper'
require 'barr/block'

RSpec.describe Barr::Block do

  describe '#initialize' do
    subject { described_class.new }

    it 'sets #output to an empty string' do
      expect(subject.output).to eq ''
    end

    context 'defaults' do
      it 'has the correct `align`' do
        expect(subject.align).to eq :l
      end

      it 'has the correct `bgcolor`' do
        expect(subject.bgcolor).to eq '-'
      end

      it 'has the correct `fgcolor`' do
        expect(subject.fgcolor).to eq '-'
      end

      it 'has the correct `icon`' do
        expect(subject.icon).to eq ''
      end

      it 'has the correct `interval`' do
        expect(subject.interval).to eq 5
      end
    end
  end

  describe '#<<' do
    subject { described_class.new }

    it 'appends to the output' do
      expect { subject << 'test' }.to change { subject.output }.from('').to('test')
    end
  end

  describe '#color_out' do
    subject { described_class.new bgcolor: '#000', fgcolor: '#FFF' }

    it 'renders correctly' do
      expect(subject.color_out).to eq('%{B#000}%{F#FFF}')
    end
  end

  describe '#draw' do
    subject { described_class.new icon: 'I', bgcolor: '#000' }

    before { subject << 'test' }

    it 'renders correctly' do
      expect(subject.draw).to eq '%{B#000}%{F-} I test '
    end
  end

end
