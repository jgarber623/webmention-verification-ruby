module Webmention
  module Verification
    class Verifier
      attr_reader :response, :target_uri

      def initialize(response:, target_uri:, strict: true)
        self.response = response
        self.target_uri = target_uri

        @strict = strict
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

      def response=(response)
        raise ArgumentError, "response must be an HTTP::Response (given #{response.class.name})" unless response.is_a?(HTTP::Response)
        raise UnsupportedMimeTypeError, "Unsupported MIME Type: #{response.mime_type}" unless self.class.mime_types.include?(response.mime_type)

        @response = response
      end

      def target_uri=(target_uri)
        raise ArgumentError, "target_uri must be an Addressable::URI (given #{target_uri.class.name})" unless target_uri.is_a?(Addressable::URI)

        @target_uri = target_uri
      end
    end
  end
end
