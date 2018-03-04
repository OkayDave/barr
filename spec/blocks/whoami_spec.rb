require 'barr/blocks/whoami'

RSpec.describe Barr::Blocks::Whoami do
  before do
    allow(subject).to receive(:sys_cmd).and_return('dave')
  end

  describe '#update!' do
    before { subject.update! }

    it 'sets the output correctly' do
      expect(subject.output).to eq('dave')
    end
  end
end
