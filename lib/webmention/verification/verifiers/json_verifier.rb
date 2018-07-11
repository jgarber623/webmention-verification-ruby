module Webmention
  module Verification
    class JsonVerifier < Verifier
      def self.mime_types
        ['application/json']
      end

      private

      def comparator(value)
        value.is_a?(String) && value.match?(target_regexp)
      end

      def locate(object, matches = [])
        if object.is_a?(Enumerable)
          matches << object if object.any? { |_, value| comparator(value) }

          (object.respond_to?(:values) ? object.values : object.entries).each do |obj|
            locate(obj, matches)
          end
        end

        matches
      end

      def parse_response_body
        locate(JSON.parse(response_body))
      end

      def target_regexp
        @target_regexp ||= /^#{target_regexp_str}$/
      end
    end
  end
end
