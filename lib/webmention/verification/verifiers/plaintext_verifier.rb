module Webmention
  module Verification
    class PlaintextVerifier < Verifier
      def results
        response.body.to_s.scan(target_regexp)
      end

      def self.mime_types
        ['text/plain']
      end

      private

      def target_regexp
        regexp_str = target_uri.to_s
        regexp_str = regexp_str.sub(%r{https?://}, 'https?://') unless @strict

        /(?:^|\s)#{regexp_str}(?:\s|$)/
      end
    end
  end
end
