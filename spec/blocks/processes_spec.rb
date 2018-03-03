require 'barr/blocks/processes'

RSpec.describe Barr::Blocks::Processes do
  let(:sys_cmd) { '468' }

  before { allow(subject).to receive(:sys_cmd).and_return(sys_cmd) }

  it 'sets number of active processes' do
    subject.update
    expect(subject.output).to eq('468')
  end
end
