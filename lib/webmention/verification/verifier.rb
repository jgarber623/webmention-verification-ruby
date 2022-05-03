# frozen_string_literal: true

module Webmention
  module Verification
    class Verifier
      class << self
        attr_reader :mime_types
      end

      def initialize(response, target, **options)
        @response = response
        @target = target.to_str
        @options = options
      end

      def results
        @results ||= parse_response_body
      end

      def verified?
        results.any?
      end

      private

      def response_body
        @response_body ||= @response.body.to_s
      end

      def target_regexp
        @target_regexp ||= /^#{target_regexp_str}$/
      end

      def target_regexp_str
        return @target if @options.fetch(:strict, true)

        @target.sub(%r{https?://}, 'https?://')
      end
    end
  end
end
