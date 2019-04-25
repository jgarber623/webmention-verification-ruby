module Webmention
  module Verification
    module Verifiers
      extend Registerable

      class BaseVerifier
        def initialize(response, target, **options)
          raise ArgumentError, "response must be an HTTP::Response (given #{response.class.name})" unless response.is_a?(HTTP::Response)
          raise ArgumentError, "target must be a String (given #{target.class.name})" unless target.is_a?(String)

          @response = response
          @target = target
          @options = options

          raise UnsupportedMimeTypeError, "Unsupported MIME Type: #{response.mime_type}" unless self.class.mime_types.include?(response.mime_type)
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

        def target_regexp_str
          return @target if @options.fetch(:strict, true)

          @target.sub(%r{https?://}, 'https?://')
        end
      end
    end
  end
end
