require 'barr/blocks/mem'

RSpec.describe Barr::Blocks::Mem do

  describe '#update!' do
    let(:sys_cmd) { '6.0G / 15.6G' }

    before do
      allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
      subject.update!
    end

    it 'sets the data correctly' do
      expect(subject.data).to eq '6.0G / 15.6G'
    end
  end

end
