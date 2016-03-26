require 'spec_helper'

Mem = Barr::Blocks::Mem

describe Mem do
  before { @b = Mem.new }
  it "exists" do
    expect(@b).to be_a_kind_of(Barr::Blocks::Mem)
    expect(@b).to be_a_kind_of(Barr::Block)
  end

  it "renders the correct format" do
    @b.update
    expect(@b.output).to match(/\d+M \/ \d+M/)
  end
end
