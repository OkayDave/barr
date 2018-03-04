
require 'barr/blocks/mpd'

RSpec.describe Barr::Blocks::MPD do
  let(:sys_cmd) { 'Muse - Knights Of Cydonia' }

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
        expect(subject.output).to eq('Muse - Knights Of Cydonia %{A:mpc prev:}%{A} %{A:mpc toggle:}%{A} %{A:mpc next:}%{A}')
      end
    end

    context 'with only artist enabled' do
      subject { described_class.new title: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Muse')
      end
    end

    context 'with only title enabled' do
      subject { described_class.new artist: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Knights Of Cydonia')
      end
    end

    context 'with only buttons enabled' do
      subject { described_class.new title: false, artist: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('%{A:mpc prev:}%{A} %{A:mpc toggle:}%{A} %{A:mpc next:}%{A}')
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
