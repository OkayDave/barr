require 'spec_helper'

Battery = Barr::Blocks::Battery

describe Barr::Blocks::Battery do
  it "parses user input correctly" do
    b = Battery.new
    b.update
    if b.instance_variable_get(:@showRemaining) == true
      expect(b.output).to eq(`acpi | cut -d `,` -f 2-3`)
    else
      expect(b.output).to eq(`acpi | cut -d ',' -f 2`)
    end
  end
end
