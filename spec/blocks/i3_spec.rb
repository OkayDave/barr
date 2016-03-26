require 'spec_helper'

class I3Test < Barr::Blocks::I3

  def i3_connection
    I3ConnectionTest.new
  end
end

class I3ConnectionTest
  def close
    true
  end

  def workspaces
    @workspaces ||= [WorkspaceTest.new(1, "a"), WorkspaceTest.new(2, "b"), WorkspaceTest.new(3, "c", true)] 
  end 
end

class WorkspaceTest
  attr_accessor :focused, :name, :num

  def initialize(num, name, focused=false)
    @focused = focused
    @num = num
    @name = name
  end
end

describe Barr::Blocks::I3 do
  describe '#initialize' do
    it "sets default focus_markers" do
      @b = I3Test.new

      expect(@b.focus_markers).to eq([">", "<"])
    end

    it "accepts focus_markers option" do
      @b = I3Test.new focus_markers: ["l","r"]

      expect(@b.focus_markers).to eq(["l","r"])
    end

    it "sets an i3 connection" do
      @b = I3Test.new

      expect(@b.i3).to_not be_nil()
    end
    
  end

  describe "#update" do
    before do
      @b = I3Test.new 
      @b.update
    end

    it "sets the workspaces" do
      expect(@b.workspaces).to be_a_kind_of(Array)
      expect(@b.workspaces.length).to eq(3)
    end

    it "renders to the correct format" do
      expect(@b.output).to eq("%{A:barr_i3ipc workspace 1:} a %{A}%{A:barr_i3ipc workspace 2:} b %{A}>c<")
    end
  end

  describe "set markers" do
    before { @b = I3Test.new focus_markers: ["(",")"]}

    it "renders the set left marker" do
      expect(@b.l_marker).to eq("(")
    end

    it "renders the set right marker" do
      expect(@b.r_marker).to eq(")")
    end
  end

  describe "default markers" do
    it "renders default left marker" do
      expect(I3Test.new.l_marker).to eq(">")
    end

    it "renders default right marker" do
      expect(I3Test.new.r_marker).to eq("<")
    end
  end
end
