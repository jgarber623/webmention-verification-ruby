require 'addressable/uri'
require 'http'

require 'webmention/verification/version'
require 'webmention/verification/error'
require 'webmention/verification/client'
require 'webmention/verification/verifier'

require 'webmention/verification/verifiers/json_verifier'
require 'webmention/verification/verifiers/plaintext_verifier'

module Webmention
  module Verification
    def self.verified?(source, target)
      Client.new(source, target).verified?
    end
  end
end
