require 'barr/blocks/cpu'

RSpec.describe Barr::Blocks::CPU do

  describe '#update!' do
    let(:sys_cmd) { '%Cpu(s):  7.9 us,  1.2 sy,  1.7 ni, 88.6 id,  0.5 wa' }

    before do
      allow(subject).to receive(:sys_cmd).and_return(sys_cmd)
      subject.update!
    end

    it 'sets the data correctly' do
      expect(subject.output).to eq '11.4%'
    end
  end

end
