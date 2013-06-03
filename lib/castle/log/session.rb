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
        tick * @data.values[0].length
      end

    end

  end
end
