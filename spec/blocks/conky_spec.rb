require 'barr/blocks/conky'

RSpec.describe Barr::Blocks::Conky do
  before do
    allow_any_instance_of(described_class).to receive(:spawn_conky).and_return(true)
    allow_any_instance_of(described_class).to receive(:write_template).and_return(true)
    allow_any_instance_of(described_class).to receive(:sys_cmd).and_return('0.2 0.2')
  end

  describe 'initialize' do
    it 'accepts text option' do
      expect(described_class.new(text: '${cpu}').text).to eq('${cpu}')
    end

    it 'spawns the conky' do
      expect(described_class.new).to have_received(:spawn_conky).once
      expect(described_class.new).to have_received(:write_template).once
    end
  end

  describe 'update' do
    it 'renders the correct format' do
      subject.update

      expect(subject.output).to eq('0.2 0.2')
    end
  end
end
