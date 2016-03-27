require 'barr/blocks/temperature'
require './spec/mocks/weather'

RSpec.describe Barr::Blocks::Temperature do

  describe '#update!' do
    subject { described_class.new location: '12723' }

    before do
      allow(subject).to receive(:weather).and_return(WeatherMock.new)
      subject.update!
    end

    it 'sets the data correctly' do
      expect(subject.data).to eq '%{A:xdg-open weather.yahoo.com/country/state/city-12723/:}100°C Nice day%{A}'
    end
  end

end
