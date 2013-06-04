module Castle
  module Log

    # Represents a single session from a Castle data logger file.
    class Session

      attr_reader :tick

      attr_reader :source

      def initialize tick, source, data
        @tick = tick
        @source = source
        @data = data
      end

      def duration
        @duration ||= tick * @data.values[0].length
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
        # FIXME current values seem pretty funky...
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

      def speed
        # FIXME need a pole count or something here
        @speed ||= int_fields 'Speed'
      end

      private

      def present? name
        !@data[name].empty?
      end

      def int_fields name
        @data[name].map(&:to_i)
      end

      def float_fields name
        @data[name].map(&:to_f)
      end

    end

  end
end
