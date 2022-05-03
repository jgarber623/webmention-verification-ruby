# frozen_string_literal: true

module Webmention
  module Verification
    module Verifiers
      def self.register(klass)
        klass.mime_types.each { |mime_type| registered[mime_type] = klass }
      end

      def self.registered
        @registered ||= {}
      end
    end
  end
end
