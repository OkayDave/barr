require 'barr/blocks/ip'

RSpec.describe Barr::Blocks::IP do

  describe '#initialize' do
    it 'sets a default device' do
      expect(subject.device).to eq 'lo'
    end
  end

  context 'IPv4 address' do
    describe '#update!' do
      let(:sys_cmd) { '192.168.1.100/24' }

      before do
        allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
        subject.update!
      end

      it 'sets the data correctly' do
        expect(subject.data).to eq 'lo > 192.168.1.100'
      end
    end
  end

  context 'IPv6 address' do
    describe '#update!' do
      subject { described_class.new ipv6: true }

      let(:sys_cmd) { 'dead::beef/64' }

      before do
        allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
        subject.update!
      end

      it 'sets the data correctly' do
        expect(subject.data).to eq 'lo > dead::beef'
      end
    end
  end

end
