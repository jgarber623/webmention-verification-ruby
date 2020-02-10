require 'json'

require 'addressable/uri'
require 'http'
require 'nokogiri'

require 'webmention/verification/version'
require 'webmention/verification/exceptions'

require 'webmention/verification/client'
require 'webmention/verification/http_request'

require 'webmention/verification/verifiers'
require 'webmention/verification/verifiers/base_verifier'
require 'webmention/verification/verifiers/html_verifier'
require 'webmention/verification/verifiers/json_verifier'
require 'webmention/verification/verifiers/plaintext_verifier'

module Webmention
  module Verification
    class << self
      def client(*args)
        Client.new(*args)
      end

      def verified?(*args)
        client(*args).verified?
      end
    end
  end
end
