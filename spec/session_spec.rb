require 'spec_helper'

describe Castle::Log::Session do

  context 'data file long-flight.csv' do

    before(:all) { @file = Castle::Log::File.new(data_file('long-flight.csv')) }

    subject { @file }

    it { is_expected.to have(1).sessions }

    context 'session 1' do

      subject { @file.sessions[0] }

      its(:duration) { should be_within(0.1).of(569.2) }

      its(:milliseconds) { should have(2846).values }

      it 'should have some select millisecond values' do
        expect(subject.milliseconds[0]).to eql(0.0)
        expect(subject.milliseconds[1500]).to eql(300000.0)
        expect(subject.milliseconds[2602]).to eql(520400.0)
      end

      its(:throttle?) { should be true }

      its(:throttle) { should have(2846).values }

      it 'should have some select throttle values' do
        expect(subject.throttle[0]).to be_within(0.001).of(0.97)
        expect(subject.throttle[1500]).to be_within(0.001).of(1.777)
        expect(subject.throttle[2602]).to be_within(0.001).of(1.785)
      end

      its(:power_out?) { should be true }

      its(:power_out) { should have(2846).values }

      it 'should have some select power-out values' do
        expect(subject.power_out[0]).to be_within(0.001).of(0)
        expect(subject.power_out[1750]).to be_within(0.001).of(87.843)
        expect(subject.power_out[2345]).to be_within(0.001).of(88.235)
      end

      its(:voltage?) { should be true }

      its(:voltage) { should have(2846).values }

      it 'should have some select voltage values' do
        expect(subject.voltage[0]).to be_within(0.001).of(0)
        expect(subject.voltage[150]).to be_within(0.001).of(40.15)
        expect(subject.voltage[2350]).to be_within(0.001).of(36.55)
      end

      its(:ripple?) { should be true }

      its(:ripple) { should have(2846).values }

      it 'should have some select ripple values' do
        expect(subject.ripple[0]).to be_within(0.001).of(0)
        expect(subject.ripple[550]).to be_within(0.001).of(0.845)
        expect(subject.ripple[2152]).to be_within(0.001).of(1.479)
      end

      its(:current?) { should be true }

      its(:current) { should have(2846).values }

      it 'should have some select current values' do
        expect(subject.current[0]).to be_within(0.001).of(0)
        expect(subject.current[1540]).to be_within(0.001).of(22.0)
        expect(subject.current[2160]).to be_within(0.001).of(36.7)
      end

      its(:temperature?) { should be true }

      its(:temperature) { should have(2846).values }

      it 'should have some select temperature values' do
        expect(subject.temperature[0]).to be_within(0.001).of(76.8)
        expect(subject.temperature[1350]).to be_within(0.001).of(115.1)
        expect(subject.temperature[2504]).to be_within(0.001).of(114.1)
      end

      its(:speed?) { should be true }

      its(:speed) { should have(2846).values }

      it 'should have some select speed values' do
        expect(subject.speed(0.02)[0]).to be_within(0.01).of(0.0)
        expect(subject.speed(0.02)[1250]).to be_within(0.01).of(1822.92)
        expect(subject.speed(0.02)[2150]).to be_within(0.01).of(1687.32)
      end

    end

  end

end
