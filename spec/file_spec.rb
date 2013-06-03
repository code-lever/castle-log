require 'spec_helper'

describe Castle::Log::File do

  context 'data file long-flight.csv' do

    subject { Castle::Log::File.new(data_file('long-flight.csv')) }

    it { should have(1).sessions }

  end

  context 'data file multi-line-notes.csv' do

    subject { Castle::Log::File.new(data_file('multi-line-notes.csv')) }

    it { should have(1).sessions }

    it 'should have a multi-line note field' do
      subject.notes.split("\n").should have(3).lines
    end

  end

  context 'data file multi-session-1.csv' do

    subject { Castle::Log::File.new(data_file('multi-session-1.csv')) }

    it { should have(5).sessions }

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

  it 'should raise on bad input' do
    expect { Castle::Log::File.new(__FILE__) }.to raise_error
  end

end
