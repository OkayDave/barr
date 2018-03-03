
require 'barr/blocks/hue_light'

RSpec.describe Barr::Blocks::HueLight do
  describe '#update!' do
    before do
      subject.id = 5
    end

    describe 'the output' do
      it 'sets the default off button correctly' do
        subject.format = '${OFF}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 off:}[off]%{A}'
      end

      it 'sets the default on button correctly' do
        subject.format = '${ON}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 on:}[on]%{A}'
      end

      it 'sets custom text correctly' do
        subject.format = '${OFF:T-custom off}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 off:}[custom off]%{A}'
      end

      it 'sets hue correctly' do
        subject.format = '${ON:H-1500}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 --hue 1500:}[on]%{A}'
      end

      it 'sets alerts correctly' do
        subject.format = '${ON:A-lselect}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 --alert lselect:}[on]%{A}'
      end

      it 'sets brightness correctly' do
        subject.format = '${ON:B-25}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 --brightness 25:}[on]%{A}'
      end

      it 'sets multiple options correctly' do
        subject.format = '${ON:B-200,T-Quite Bright,H-65000}'
        subject.update!
        expect(subject.output).to eq '%{A:hue light 5 --brightness 200 --hue 65000:}[Quite Bright]%{A}'
      end

      it 'sets multiple buttons correctly' do
        subject.format = '${OFF:T-turn off} ${ON}'
        subject.update!
        expect(subject.output).to eq('%{A:hue light 5 off:}[turn off]%{A} %{A:hue light 5 on:}[on]%{A}')
      end
    end
  end
end
