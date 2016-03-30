require 'barr/blocks/separator'

RSpec.describe Barr::Blocks::Separator do

  describe '#update!' do
    before { subject.update! }

    it 'outputs the string' do
      expect(subject.output).to eq '|'
    end
  end

end
