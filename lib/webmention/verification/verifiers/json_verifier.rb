module Webmention
  module Verification
    class JsonVerifier < Verifier
      def results; end

      def self.mime_types
        ['application/json']
      end
    end
  end
end
