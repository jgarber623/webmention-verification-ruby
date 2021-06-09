module Webmention
  module Verification
    class Client
      HTTP_CLIENT_HEADERS = {
        accept:     '*/*',
        user_agent: 'Webmention Verification Client (https://rubygems.org/gems/webmention-verification)'
      }.freeze

      attr_reader :source, :target

      # Create a client used to determine whether or not source URI links to target URI.
      #
      # @example
      #   source = 'https://source.example.com/post/100'
      #   target = 'https://target.example.com/post/100'
      #
      #   client = Webmention::Verification::Client.new(source, target)
      #
      #   puts client.verified?
      #   #=> TrueClass or FalseClass
      #
      # @param source [String]
      # @param target [String]
      # @param options [Hash]
      # @option options [Boolean] :strict (true)
      def initialize(source, target, **options)
        @source = source.to_str
        @target = target.to_str
        @options = options

        raise ArgumentError, 'source must be an absolute URI (e.g. https://example.com/post/100)' unless source_uri.absolute?
        raise ArgumentError, 'target must be an absolute URI (e.g. https://example.com/post/100)' unless target_uri.absolute?
      end

      # @return [String]
      def inspect
        format(%(#<#{self.class.name}:%#0x source: #{source.inspect} target: #{target.inspect} options: #{@options.inspect}>), object_id)
      end

      # @return [HTTP::Response]
      # @raise [Webmention::Verification::ConnectionError, Webmention::Verification::TimeoutError, Webmention::Verification::TooManyRedirectsError]
      def response
        @response ||= HTTP.follow.headers(HTTP_CLIENT_HEADERS).timeout(connect: 10, read: 10).get(source_uri)
      rescue HTTP::Error => exception
        raise HttpError, exception
      end

      # @return [Addressable::URI]
      # @raise [Webmention::Verification::InvalidURIError]
      def source_uri
        @source_uri ||= Addressable::URI.parse(source)
      rescue Addressable::URI::InvalidURIError => exception
        raise InvalidURIError, exception
      end

      # @return [Addressable::URI]
      # @raise [Webmention::Verification::InvalidURIError]
      def target_uri
        @target_uri ||= Addressable::URI.parse(target)
      rescue Addressable::URI::InvalidURIError => exception
        raise InvalidURIError, exception
      end

      # @return [Boolean]
      # @raise [Webmention::Verification::UnsupportedMimeTypeError]
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
