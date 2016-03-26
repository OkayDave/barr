require 'spec_helper'

class MemTest < Barr::Blocks::Mem
  def sys_cmd
    return "7634M / 15909M"
  end
end

describe Barr::Blocks::Mem do
  before { @b = MemTest.new }
  it "exists" do
    expect(@b).to be_a_kind_of(Barr::Blocks::Mem)
    expect(@b).to be_a_kind_of(Barr::Block)
  end

  it "renders the correct format" do
    @b.update
    expect(@b.output).to match(/\d+M \/ \d+M/)
  end
end
