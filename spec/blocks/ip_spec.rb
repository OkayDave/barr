require 'spec_helper'

class IpTest < Barr::Blocks::Ip
  def sys_cmd
    return "192.168.0.2/24 enp3s0"
  end
end

describe Barr::Blocks::Ip do
  before { @b = IpTest.new }

  describe "#initialize" do
    it "sets default device" do
      expect(IpTest.new.device).to eq("192")
    end

    it "accepts device option" do
      expect(IpTest.new(device: "dev").device).to eq("dev")
    end
  end

  describe "#update" do
    it "renders correct format" do
      @b.update

      expect(@b.output).to match(/.+ > \d{,3}\.\d{,3}\.\d{,3}\.\d{,3}/)
    end
  end
end
