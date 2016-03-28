# coding: utf-8
require 'barr/blocks/rhythmbox'

RSpec.describe Barr::Blocks::Rhythmbox do

  let(:sys_cmd) { 'Marilyn Manson - Into The Fire' }

  before do
    allow(subject).to receive(:running?).and_return(true)
    allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
  end

  describe '#initialize' do
    it 'sets default options' do
      expect(subject.view_opts[:artist]).to eq true
      expect(subject.view_opts[:buttons]).to eq true
      expect(subject.view_opts[:title]).to eq true
    end
  end

  describe '#update!' do
    context 'with everything enabled' do
      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Marilyn Manson - Into The Fire %{A:rhythmbox-client --previous:}%{A} %{A:rhythmbox-client --play-pause:}%{A} %{A:rhythmbox-client --next:}%{A}')
      end
    end

    context 'with only artist enabled' do
      subject { described_class.new title: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Marilyn Manson')
      end
    end

    context 'with only title enabled' do
      subject { described_class.new artist: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Into The Fire')
      end
    end

    context 'with only buttons enabled' do
      subject { described_class.new title: false, artist: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('%{A:rhythmbox-client --previous:}%{A} %{A:rhythmbox-client --play-pause:}%{A} %{A:rhythmbox-client --next:}%{A}')
      end
    end

    context 'when nothing is playing' do
      subject { described_class.new buttons: false }

      before do
        allow(subject).to receive(:running?).and_return(false)

        subject.update!
      end

      it 'sets the output correctly' do
        expect(subject.output).to eq('None')
      end
    end
  end
end
