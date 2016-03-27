require 'barr/blocks/clock'
 
RSpec.describe Barr::Blocks::Clock do
  describe '#update!' do
    subject { described_class.new format: '%Y' }

    before { subject.update! }

    it 'sets the correct output' do
      expect(subject.data).to eq(Time.now.year.to_s)
    end
  end
end
