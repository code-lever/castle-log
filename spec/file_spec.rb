require 'spec_helper'

describe Castle::Log::File do

  describe '#new' do

    context 'data file long-flight.csv' do

      subject { Castle::Log::File.new(data_file('long-flight.csv')) }

      it { should have(1).sessions }

      its(:duration) { should be_within(0.1).of(569.2) }

    end

    context 'data file multi-line-notes.csv' do

      subject { Castle::Log::File.new(data_file('multi-line-notes.csv')) }

      it { should have(1).sessions }

      it 'should have a multi-line note field' do
        expect(subject.notes.split("\n")).to have(3).lines
      end

    end

    context 'data file multi-session-1.csv' do

      subject { Castle::Log::File.new(data_file('multi-session-1.csv')) }

      it { should have(5).sessions }

      its(:duration) { should be_within(0.1).of(945.0) }

      its(:notes) { should eql('Agri-duck 14 sep 12') }

    end

    context 'data file multi-session-2.csv' do

      subject { Castle::Log::File.new(data_file('multi-session-2.csv')) }

      it { should have(7).sessions }

    end

    context 'data file sample-1.csv' do

      subject { Castle::Log::File.new(data_file('sample-1.csv')) }

      it { should have(1).sessions }

    end

    it 'should raise for invalid or missing files' do
      files = invalid_data_files
      files.should have(21).files

      files.each do |f|
        expect { Castle::Log::File.new(f) }.to raise_error
      end
    end

  end

  describe '#castle?' do

    it 'should be false for invalid or missing files' do
      files = invalid_data_files
      files.should have(21).files

      files.each do |f|
        Castle::Log::File.castle?(f).should be_false
      end
    end

    it 'should be true for valid files' do
      files = data_files
      files.should have(5).files

      files.each do |f|
        expect(Castle::Log::File.castle?(f)).to be_true
      end
    end

    it 'should return a file object' do
      expect(Castle::Log::File.castle?(data_files[0])).to be_a(Castle::Log::File)
    end

    it 'should return nil when invalid' do
      expect(Castle::Log::File.castle?(invalid_data_files[0])).to be_nil
    end

  end

end
