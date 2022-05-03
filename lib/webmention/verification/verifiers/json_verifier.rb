# frozen_string_literal: true

module Webmention
  module Verification
    module Verifiers
      class JsonVerifier < Verifier
        @mime_types = ['application/json']

        Client.register_verifier(self)

        private

        def parse_response_body
          DeepLocator.new(JSON.parse(response_body), target_regexp).results
        end

        class DeepLocator
          def initialize(json, pattern)
            @json = json
            @pattern = pattern
          end

          def results
            @results ||= build_results(comparator, @json)
          end

          def self.values_for(object)
            object.is_a?(Hash) ? object.values : object.entries
          end

          private

          def build_results(comparator, object, matches = [])
            return matches unless object.is_a?(Enumerable)

            matches << object if object.any? { |_, value| comparator.call(value) }

            self.class.values_for(object).each { |value| build_results(comparator, value, matches) }

            matches
          end

          def comparator
            @comparator ||= ->(value) { value.is_a?(String) && value.match?(@pattern) }
          end
        end
      end
    end
  end
end
