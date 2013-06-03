require 'spec_helper'

describe Castle::Log::Session do

  context 'data file long-flight.csv' do

    let(:file) { Castle::Log::File.new(data_file('long-flight.csv')) }

    subject { file }

    it { should have(1).sessions }

    context 'session 1' do

      subject { file.sessions[0] }

      its(:duration) { should be_within(0.1).of(569.2) }

    end

  end

end
