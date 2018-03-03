require 'spec_helper'
require './spec/mocks/playerctl'

RSpec.describe Barr::Blocks::PlayerctlBlockMock do

  describe '#initialize' do
    it "sets default format" do
      expect(subject.format).to eq("${ARTIST} - ${TITLE}")
    end
  end

  describe 'config' do
    it "sets the controller" do
      subject.config
      expect(subject.controller).to be_a(Barr::Controllers::PlayerctlControllerMock)
    end
  end

  describe 'update' do
    it "sets the output correctly" do
      subject.format = "${ARTIST} - ${ALBUM} - ${NEXT}"
      subject.config
      subject.controller.update!
      subject.update!
      expect(subject.output).to eq("Slayer - Reign in Blood - %{A:playerctl next:}\uf051%{A}")
    end
  end

end
