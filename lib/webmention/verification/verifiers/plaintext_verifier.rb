# frozen_string_literal: true

module Webmention
  module Verification
    module Verifiers
      class PlaintextVerifier < BaseVerifier
        @mime_types = ['text/plain']

        Verifiers.register(self)

        private

        def parse_response_body
          response_body.scan(target_regexp)
        end

        def target_regexp
          @target_regexp ||= /(?:^|\s)#{target_regexp_str}(?:\s|$)/
        end
      end
    end
  end
end
