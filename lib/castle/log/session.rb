module Castle
  module Log

    # Represents a single session from a Castle data logger file.
    class Session

      attr_reader :tick

      attr_reader :source

      def initialize(tick, source, data)
        @tick = tick
        @source = source
        @data = data
      end

      # Gets the duration of the session, in seconds.
      #
      # @return [Float] duration of the session, in seconds
      def duration
        @duration ||= tick * @data.values[0].length
      end

      # Gets an array of millisecond times that correspond to data points.
      #
      # @return [Array] millisecond times corresponding to data points
      def milliseconds
        @milliseconds ||= build_milliseconds
      end

      def throttle?
        present? 'Throttle'
      end

      def throttle
        @throttle ||= float_fields 'Throttle'
      end

      def power_out?
        present? 'Power-Out'
      end

      def power_out
        @power_out ||= float_fields 'Power-Out'
      end

      def voltage?
        present? 'Voltage'
      end

      def voltage
        @voltage ||= float_fields 'Voltage'
      end

      def ripple?
        present? 'Ripple'
      end

      def ripple
        @ripple ||= float_fields 'Ripple'
      end

      def current?
        present? 'Current'
      end

      def current
        @current ||= float_fields 'Current'
      end

      def temperature?
        present? 'Temperature'
      end

      def temperature
        @temperature ||= float_fields 'Temperature'
      end

      def speed?
        present? 'Speed'
      end

      # Gets the speed field values.
      #
      # @param [Float] factor value to multiply each speed by
      # @return [Array] speed field values
      def speed(factor = 1.0)
        @speed ||= int_fields('Speed').map { |s| s * factor }
      end

      private

      def build_milliseconds
        count = @data.values[0].length
        increment = tick * 1000.0
        count.times.map { |i| i * increment }
      end

      def present?(name)
        !@data[name].empty?
      end

      def int_fields(name)
        @data[name].map(&:to_i)
      end

      def float_fields(name)
        @data[name].map(&:to_f)
      end

    end

  end
end
