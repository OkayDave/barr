require 'barr/blocks/i3'
require './spec/mocks/i3'

RSpec.describe Barr::Blocks::I3 do

  before do
    allow_any_instance_of(described_class).to receive(:i3_connection).and_return(I3IpcMock.new)
  end

  describe '#initialize' do
    it 'sets default focus_markers' do
      expect(subject.focus_markers).to eq %w(> <)
    end

    it 'sets an i3 connection' do
      expect(subject.i3).to be_a I3IpcMock
    end

  end

  describe '#update!' do
    before { subject.update! }

    it 'sets the workspaces' do
      expect(subject.workspaces.length).to eq 3
    end

    it 'renders to the correct format' do
      expect(subject.output).to eq '%{A:barr_i3ipc "workspace a":} a %{A}%{A:barr_i3ipc "workspace 2\: b":} 2: b %{A}>c<'
    end
  end

end
