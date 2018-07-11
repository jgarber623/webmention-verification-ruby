module Webmention
  module Verification
    class PlaintextVerifier < Verifier
      def self.mime_types
        ['text/plain']
      end

      private

      def parse_response_body
        response_body.scan(target_regexp)
      end

      def target_regexp
        /(?:^|\s)#{target_regexp_str}(?:\s|$)/
      end
    end
  end
end
