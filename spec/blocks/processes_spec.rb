require 'spec_helper'

Processes = Barr::Blocks::Processes

describe Barr::Blocks::Processes do
  it "sets number of active processes" do
	b = Processes.new
	b.update
	expect(b.output).to eq(`ps -e | wc -l`)
  end
end
