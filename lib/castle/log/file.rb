require 'open-uri'

module Castle
  module Log

    # Represents a single Castle data logger file.
    class File

      attr_reader :date_saved

      # @return [String] Notes at the beginning of the file
      attr_reader :notes

      # @return [Array<Session>] Sessions contained in this file
      attr_reader :sessions

      def initialize uri
        @sessions = []

        open(uri, 'rb') do |file|

          i = 0
          in_comment = false
          lines = file.readlines.map(&:strip).group_by do |line|
            if line.start_with?('#') && !in_comment
              in_comment = true
              i += 1
            elsif !line.start_with?('#') && in_comment
              in_comment = false
            end
            i
          end

          # session 1 has some extra metadata, scrape that out first
          notes = lines[1].select { |line| line.start_with?('# Note') }
          meta = lines[1].select { |line| line.start_with?('# Graph Data') }

          @sessions = extract_sessions(lines)

          @notes = (notes.map { |line| /Note -(?<note>.*)$/.match(line)[:note].strip }).join("\n")

          # TODO validate expected number of sessions from meta
          # TODO extract date_saved

        end

      rescue
        raise ArgumentError, 'File does not appear to be an Castle data log'
      end

      private

      def extract_sessions line_hash

        keys = line_hash.keys.sort!
        keys.map do |session_index|
          lines = line_hash[session_index]
          start = lines.select { |line| line.start_with?('# Start Of Session') }
          reset = lines.select { |line| line.start_with?('# Reset Source') }
          tick = /Sample Time: (?<tick>\d+.\d+)/.match(start[0])[:tick].strip.to_f
          source = /\(Cause of reset\): (?<source>.*)/.match(reset[0])[:source].strip

          # XXX can we use CSV for this instead?

          # strip out comment rows
          raw_rows = lines.reject { |line| line.start_with?('#') }

          # pop off header rows
          headers = raw_rows.shift.split(',').map(&:strip)
          booleans = raw_rows.shift.split(',').map(&:strip) # XXX unused, what is this?

          # split the rows up and flip them into columns of data
          columns = (raw_rows.map { |row| row.split(',').map(&:strip) }).transpose

          # build the data hash as expected by the session
          data = (columns.each_with_index.map { |column, idx| { headers[idx] => column } }).reduce({}, :merge)

          Session.new(tick, source, data)

        end

      end

    end

  end
end
