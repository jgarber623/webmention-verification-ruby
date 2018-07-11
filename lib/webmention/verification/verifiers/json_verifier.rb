module Webmention
  module Verification
    class JsonVerifier < Verifier
      def self.mime_types
        ['application/json']
      end

      private

      def parse_response_body; end
    end
  end
end
