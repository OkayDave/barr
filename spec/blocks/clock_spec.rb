require 'barr/blocks/clock'

RSpec.describe Barr::Blocks::Clock do
  describe '#update!' do
    before do
      time = Time.local(2016, 3, 17, 20, 0, 0)
      Timecop.travel(time)

      subject.update!
    end

    after { Timecop.return }

    it 'sets the correct output' do
      expect(subject.output).to eq '20:00 17 Mar 2016'
    end
  end
end
