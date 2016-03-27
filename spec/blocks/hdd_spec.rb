require 'barr/blocks/hdd'

RSpec.describe Barr::Blocks::HDD do

  describe '#update!' do
    subject { described_class.new device: 'sdc2' }

    let(:sys_cmd) { '213G 34G 17%' }

    before do
      allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
      subject.update!
    end

    it 'sets the data correctly' do
      expect(subject.data).to eq '34G / 213G (17%)'
    end
  end

end
