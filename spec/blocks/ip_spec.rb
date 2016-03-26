require 'spec_helper'

Ip = Barr::Blocks::Ip

describe Ip do
  before { @b = Ip.new }

  describe "#initialize" do
    it "sets default device" do
      expect(Ip.new.device).to eq("192")
    end

    it "accepts device option" do
      expect(Ip.new(device: "dev").device).to eq("dev")
    end
  end

  describe "#update" do
    it "renders correct format" do
      @b.update

      expect(@b.output).to match(/.+ > \d{,3}\.\d{,3}\.\d{,3}\.\d{,3}/)
    end
  end
end
