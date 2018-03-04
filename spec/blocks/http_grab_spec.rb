require 'spec_helper'
require './spec/mocks/http_grab'

RSpec.describe Barr::Blocks::HTTPGrabBlockMock do
  describe '#initialize' do
    it 'sets defaults' do
      expect(subject.link).to be_falsey
      expect(subject.type).to eq(:css)
    end
  end

  describe 'config' do
    it 'sets the controller' do
      subject.config
      expect(subject.controller).to be_a(Barr::Controllers::HTTPGrabControllerMock)
    end
  end

  describe 'update' do
    it 'sets the output correctly' do
      subject.url = 'http://fakedomain.com/url'
      subject.link = true
      subject.config
      subject.controller.update!
      subject.update!
      expect(subject.output).to eq('%{A:barr_open_url http fakedomain.com/url:}Top news article!%{A}')
    end
  end
end
