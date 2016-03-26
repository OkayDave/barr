require 'spec_helper'

Cpu = Barr::Blocks::Cpu

describe Cpu do
  it "exists" do
    @b = Cpu.new
    expect(Cpu.new).to be_a_kind_of(Barr::Blocks::Cpu)
    expect(Cpu.new).to be_a_kind_of(Barr::Block)
  end

  it "renders in the correct format" do
    @b = Cpu.new
    @b.update

    expect(@b.output).to match(/\d+(\.\d+|)%/)
  end

end
