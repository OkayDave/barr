require 'spec_helper'
require 'barr'
require 'barr/block'

RSpec.describe Barr::Block do

  describe '#initialize' do
    subject { described_class.new }

    context 'defaults' do
      it 'has a default alignment' do
        expect(subject.align).to eq :l
      end

      it 'has a default bgcolor' do
        expect(subject.bgcolor).to eq '-'
      end

      it 'has no default output' do
        expect(subject.output).to eq ''
      end

      it 'has a default fgcolor' do
        expect(subject.fgcolor).to eq '-'
      end

      it 'has a default icon' do
        expect(subject.icon).to eq ''
      end

      it 'has a default interval' do
        expect(subject.interval).to eq 50
      end
    end

  end

  describe '#<<' do
    subject { described_class.new }

    it 'appends to the block output' do
      expect { subject << 'test' }.to change { subject.output }.from('').to('test')
    end
  end

  describe '#colors' do
    subject { described_class.new bgcolor: '#000', fgcolor: '#FFF' }

    it 'sends color instructions' do
      expect(subject.colors).to eq('%{B#000}%{F#FFF}')
    end

    it 'warns about deprecated options' do
      opts = { bcolor: "#ccc", fcolor: "#bbb" }
      @old = described_class.new(opts)
      
      expect(@old.fgcolor).to eq("#bbb")
      expect(@old.bgcolor).to eq("#ccc")
    end
  end

  describe '#draw' do
    subject { described_class.new icon: 'I', bgcolor: '#000' }

    before { subject << 'test' }

    it 'renders correctly' do
      expect(subject.draw).to eq '%{B#000}%{F-} I test %{F-}%{B-}'
    end
  end

  describe 'aliased classes' do
    it "should not raise errors" do
      expect{[Barr::Blocks::Cpu,
              Barr::Blocks::Hdd,
              Barr::Blocks::Ip,
              Barr::Blocks::WhoAmI
             ]}.to_not raise_error
    end
  end


  describe "tmp_filename" do
    it "should return unique filename" do
      expect(subject.tmp_filename).to match(/^\/tmp\/(\w|\W|block|\d)+$/i)
    end
  end

  describe "format_string_from_hash" do
    before { subject.format = "${VAR1} ${VAR2} ${VAR3}" }

    it "substitutes the variables" do
      opts = {var1: "test", var2: "another test", var3: "word"}
      expect(subject.format_string_from_hash(opts)).to eq("test another test word")
    end

    it "blanks missing variables" do
      opts = {var1: "test"}

      expect(subject.format_string_from_hash(opts)).to eq("test  ")
    end

    it "is not case sensitive" do
      opts = {var1: "test"}
      subject.format = "${vAr1}"
      expect(subject.format_string_from_hash(opts)).to eq("test")
    end
    
  end
end
