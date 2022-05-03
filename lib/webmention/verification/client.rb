# frozen_string_literal: true

module Webmention
  module Verification
    class Client
      HTTP_CLIENT_HEADERS = {
        accept: '*/*',
        user_agent: 'Webmention Verification Client (https://rubygems.org/gems/webmention-verification)'
      }.freeze

      @registered_verifiers = {}

      class << self
        attr_reader :registered_verifiers
      end

      attr_reader :source, :target

      def self.register_verifier(klass)
        klass.mime_types.each { |mime_type| @registered_verifiers[mime_type] = klass }
      end

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

        message = 'must be an absolute URI (e.g. https://example.com/post/100)'

        raise ArgumentError, "source #{message}" unless absolute?(source_uri)
        raise ArgumentError, "target #{message}" unless absolute?(target_uri)
      end

      # @return [String]
      def inspect
        "#<#{self.class.name}:#{format('%#0x', object_id)} " \
          "source: #{source.inspect} " \
          "target: #{target.inspect} " \
          "options: #{@options.inspect}>"
      end

      # @return [HTTP::Response]
      # @raise [Webmention::Verification::HttpError, Webmention::Verification::SSLError]
      def response
        @response ||= HTTP.follow.headers(HTTP_CLIENT_HEADERS).timeout(connect: 10, read: 10).get(source_uri)
      rescue HTTP::Error => e
        raise HttpError, e
      rescue OpenSSL::SSL::SSLError => e
        raise SSLError, e
      end

      # @return [HTTP::URI]
      # @raise [Webmention::Verification::InvalidURIError]
      def source_uri
        @source_uri ||= HTTP::URI.parse(source)
      rescue Addressable::URI::InvalidURIError => e
        raise InvalidURIError, e
      end

      # @return [HTTP::URI]
      # @raise [Webmention::Verification::InvalidURIError]
      def target_uri
        @target_uri ||= HTTP::URI.parse(target)
      rescue Addressable::URI::InvalidURIError => e
        raise InvalidURIError, e
      end

      # @return [Boolean]
      # @raise [Webmention::Verification::UnsupportedMimeTypeError]
      def verified?
        self.class
            .registered_verifiers[response.mime_type]
            .new(response, target, **@options)
            .verified?
      rescue NoMethodError
        raise UnsupportedMimeTypeError, "Unsupported MIME Type: #{response.mime_type}"
      end

      private

      def absolute?(uri)
        uri.http? || uri.https?
      end
    end
  end
end
