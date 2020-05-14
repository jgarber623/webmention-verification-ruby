require 'json'

require 'addressable/uri'
require 'http'
require 'nokogiri'

require 'webmention/verification/version'
require 'webmention/verification/exceptions'

require 'webmention/verification/client'
require 'webmention/verification/verifiers'
require 'webmention/verification/verifiers/base_verifier'
require 'webmention/verification/verifiers/html_verifier'
require 'webmention/verification/verifiers/json_verifier'
require 'webmention/verification/verifiers/plaintext_verifier'

module Webmention
  module Verification
    def self.verified?(*args)
      Client.new(*args).verified?
    end
  end
end
