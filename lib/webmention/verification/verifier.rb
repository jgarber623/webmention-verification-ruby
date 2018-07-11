module Webmention
  module Verification
    class Verifier
      attr_reader :response, :target_uri

      def initialize(response:, target_uri:, strict: true)
        raise ArgumentError, "response must be an HTTP::Response (given #{response.class.name})" unless response.is_a?(HTTP::Response)
        raise UnsupportedMimeTypeError, "Unsupported MIME Type: #{response.mime_type}" unless self.class.mime_types.include?(response.mime_type)
        raise ArgumentError, "target_uri must be an Addressable::URI (given #{target_uri.class.name})" unless target_uri.is_a?(Addressable::URI)

        @response = response
        @target_uri = target_uri
        @strict = strict
      end

      def results
        @results ||= parse_response_body
      end

      def verified?
        results.any?
      end

      class << self
        def inherited(base)
          subclasses << base

          super(base)
        end

        def mime_types
          mime_types = []

          subclasses.each { |subclass| mime_types << subclass.mime_types }

          mime_types.flatten.sort
        end

        def subclasses
          @subclasses ||= []
        end
      end

      private

      def response_body
        @response_body ||= response.body.to_s
      end

      def target_regexp_str
        return target_uri.to_s if @strict

        target_uri.to_s.sub(%r{https?://}, 'https?://')
      end
    end
  end
end
