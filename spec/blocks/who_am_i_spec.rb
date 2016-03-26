require 'spec_helper'

class WhoAmITest < Barr::Blocks::WhoAmI
  def sys_cmd
    return "dave"
  end
end

describe Barr::Blocks::WhoAmI do
  it "renders output correctly" do
    b = WhoAmITest.new
    b.update

    expect(b.output).to eq("dave")
    
  end
end
