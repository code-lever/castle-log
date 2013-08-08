require 'spec_helper'

describe Castle::Log::Session do

  context 'data file long-flight.csv' do

    before(:all) { @file = Castle::Log::File.new(data_file('long-flight.csv')) }

    subject { @file }

    it { should have(1).sessions }

    context 'session 1' do

      subject { @file.sessions[0] }

      its(:duration) { should be_within(0.1).of(569.2) }

      its(:milliseconds) { should have(2846).values }

      it 'should have some select millisecond values' do
        subject.milliseconds[0].should eql(0.0)
        subject.milliseconds[1500].should eql(300000.0)
        subject.milliseconds[2602].should eql(520400.0)
      end

      its(:throttle?) { should be_true }

      its(:throttle) { should have(2846).values }

      it 'should have some select throttle values' do
        subject.throttle[0].should be_within(0.001).of(0.97)
        subject.throttle[1500].should be_within(0.001).of(1.777)
        subject.throttle[2602].should be_within(0.001).of(1.785)
      end

      its(:power_out?) { should be_true }

      its(:power_out) { should have(2846).values }

      it 'should have some select power-out values' do
        subject.power_out[0].should be_within(0.001).of(0)
        subject.power_out[1750].should be_within(0.001).of(87.843)
        subject.power_out[2345].should be_within(0.001).of(88.235)
      end

      its(:voltage?) { should be_true }

      its(:voltage) { should have(2846).values }

      it 'should have some select voltage values' do
        subject.voltage[0].should be_within(0.001).of(0)
        subject.voltage[150].should be_within(0.001).of(40.15)
        subject.voltage[2350].should be_within(0.001).of(36.55)
      end

      its(:ripple?) { should be_true }

      its(:ripple) { should have(2846).values }

      it 'should have some select ripple values' do
        subject.ripple[0].should be_within(0.001).of(0)
        subject.ripple[550].should be_within(0.001).of(0.845)
        subject.ripple[2152].should be_within(0.001).of(1.479)
      end

      its(:current?) { should be_true }

      its(:current) { should have(2846).values }

      it 'should have some select current values' do
        subject.current[0].should be_within(0.001).of(0)
        subject.current[1540].should be_within(0.001).of(22.0)
        subject.current[2160].should be_within(0.001).of(36.7)
      end

      its(:temperature?) { should be_true }

      its(:temperature) { should have(2846).values }

      it 'should have some select temperature values' do
        subject.temperature[0].should be_within(0.001).of(76.8)
        subject.temperature[1350].should be_within(0.001).of(115.1)
        subject.temperature[2504].should be_within(0.001).of(114.1)
      end

      its(:speed?) { should be_true }

      its(:speed) { should have(2846).values }

      it 'should have some select speed values' do
        subject.speed(0.02)[0].should be_within(0.01).of(0.0)
        subject.speed(0.02)[1250].should be_within(0.01).of(1822.92)
        subject.speed(0.02)[2150].should be_within(0.01).of(1687.32)
      end

    end

  end

end
