module Webmention
  module Verification
    class Client
      HTTP_HEADERS_OPTS = {
        accept:     '*/*',
        user_agent: 'Webmention Verification Client (https://rubygems.org/gems/webmention-verification)'
      }.freeze

      attr_reader :source, :target

      def initialize(source, target, **options)
        raise ArgumentError, "source must be a String (given #{source.class.name})" unless source.is_a?(String)
        raise ArgumentError, "target must be a String (given #{target.class.name})" unless target.is_a?(String)

        @source = source
        @target = target
        @options = options

        raise ArgumentError, 'source must be an absolute URI (e.g. https://example.com/post/100)' unless source_uri.absolute?
        raise ArgumentError, 'target must be an absolute URI (e.g. https://example.com/post/100)' unless target_uri.absolute?
      end

      def response
        @response ||= HTTP.follow.headers(HTTP_HEADERS_OPTS).timeout(connect: 10, read: 10).get(source_uri)
      rescue HTTP::ConnectionError,
             HTTP::TimeoutError,
             HTTP::Redirector::TooManyRedirectsError => exception
        raise Webmention::Verification.const_get(exception.class.name.split('::').last), exception
      end

      def source_uri
        @source_uri ||= Addressable::URI.parse(source)
      rescue Addressable::URI::InvalidURIError => exception
        raise InvalidURIError, exception
      end

      def target_uri
        @target_uri ||= Addressable::URI.parse(target)
      rescue Addressable::URI::InvalidURIError => exception
        raise InvalidURIError, exception
      end

      def verified?
        raise UnsupportedMimeTypeError, "Unsupported MIME Type: #{response.mime_type}" unless verifier_for_mime_type

        verifier_for_mime_type.new(response, target, @options).verified?
      end

      private

      def verifier_for_mime_type
        @verifier_for_mime_type ||= Verifiers.registered[response.mime_type]
      end
    end
  end
end
