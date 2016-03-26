# coding: utf-8
require 'spec_helper'

class BoxTest < Barr::Blocks::Rhythmbox 
  attr_writer :running
  def sys_cmd cmd
    "Marilyn Manson - Into The Fire"
  end

  def running?
    @running 
  end

  def initialize opts={}
    super
    @running = true
  end
end

describe Barr::Blocks::Rhythmbox do

  describe "#initialize" do
    it "sets default options" do
      b = BoxTest.new

      expect(b.show_title).to eq(true)
      expect(b.show_artist).to eq(true)
      expect(b.show_buttons).to eq(true)
    end

    it "accepts options" do
      b = BoxTest.new show_title: false, show_artist: false, show_buttons: false

      expect(b.show_title).to eq(false)
      expect(b.show_artist).to eq(false)
      expect(b.show_buttons).to eq(false)
    end
  end

  describe "#update" do
    it "renders properly with all enabled" do
      b = BoxTest.new
      b.update

      expect(b.output).to eq("Marilyn Manson - Into The Fire %{A:rhythmbox-client --previous:}%{A} %{A:rhythmbox-client --play-pause:}%{A} %{A:rhythmbox-client --next:}%{A}")
      
    end

    it "renders properly with only artist" do
      b = BoxTest.new show_title: false, show_buttons: false
      b.update

      expect(b.output).to eq("Marilyn Manson")
    end

    it "renders properly with only title" do
      b = BoxTest.new show_artist: false, show_buttons: false
      b.update

      expect(b.output).to eq("Into The Fire")
    end

    it "renders properly with only buttons" do
      b = BoxTest.new show_title: false, show_artist: false
      b.update

      expect(b.output).to eq("%{A:rhythmbox-client --previous:}%{A} %{A:rhythmbox-client --play-pause:}%{A} %{A:rhythmbox-client --next:}%{A}")
    end

    it "renders properly when no music playing" do
      b = BoxTest.new show_buttons: false
      b.running = false
      b.update

      expect(b.output).to eq("None")
    end
  end 
end
