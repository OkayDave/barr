# coding: utf-8
require 'barr/blocks/spotify'

RSpec.describe Barr::Blocks::Spotify do
  let(:sys_cmd) { Hash.new(title: 'Tear In My Heart',
                           artist: ['Twenty One Pilots'].join(', '),
                           album: 'Blurryface') }
  let(:dbus_play) { 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause' }
  let(:dbus_next) { 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next' }
  let(:dbus_prev) { 'dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous' }

  before do
    allow(subject).to receive(:running?).and_return(true)
    allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
  end

  describe '#initialize' do
    it 'sets the default options' do
      expect(subject.view_opts[:artist]).to eq true
      expect(subject.view_opts[:buttons]).to eq true
      expect(subject.view_opts[:title]).to eq true
    end
  end

  describe '#update' do
    context 'with everything enabled' do
      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq("Twenty One Pilots - Tear In My Heart %{A:#{dbus_prev}:}%{A} %{A:#{dbus_play}:}%{A} %{A:#{dbus_next}:}%{A}")
      end
    end

    context 'with only artist enabled' do
      subject { described_class.new title: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Twenty One Pilots')
      end
    end

    context 'with only title enabled' do
      subject { described_class.new artist: false, buttons: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq('Tear In My Heart')
      end
    end

    context 'with only buttons enabled' do
      subject { described_class.new title: false, artist: false }

      before { subject.update! }

      it 'sets the output correctly' do
        expect(subject.output).to eq("%{A:#{dbus_prev}:}%{A} %{A:#{dbus_play}:}%{A} %{A:#{dbus_next}:}%{A}")
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
