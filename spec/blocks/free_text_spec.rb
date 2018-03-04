
require 'barr/blocks/free_text'

RSpec.describe Barr::Blocks::FreeText do
  describe '#update!' do

    it 'sets the text correctly' do
      subject.text = 'Text Test'
      subject.update!
      expect(subject.output).to eq 'Text Test'
    end

  end
end
