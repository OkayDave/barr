# coding: utf-8
require 'barr/blocks/cpu'

RSpec.describe Barr::Blocks::CPU do

  describe '#update!' do
    let(:load_sys_cmd) { '6.7744' }
    let(:temp_sys_cmd) { '28500' }

    before do
      allow(subject).to receive(:load_sys_cmd).and_return(load_sys_cmd)
      allow(subject).to receive(:temp_sys_cmd).and_return(temp_sys_cmd)
    end

    it 'sets the load data correctly' do
      subject.format = '${LOAD}'
      subject.update!
      expect(subject.output).to eq '6.77%'
    end

    it 'sets the temp data correctly' do
      subject.format = '${TEMP}'
      subject.update!
      expect(subject.output).to eq '28.5°'
    end
  end

end
