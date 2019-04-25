require 'addressable/uri'
require 'http'
require 'json'
require 'nokogiri'

require 'webmention/verification/version'
require 'webmention/verification/exceptions'

require 'webmention/verification/client'
require 'webmention/verification/registerable'

require 'webmention/verification/verifiers'
require 'webmention/verification/verifiers/html_verifier'
require 'webmention/verification/verifiers/json_verifier'
require 'webmention/verification/verifiers/plaintext_verifier'

module Webmention
  module Verification
    def self.verified?(source, target)
      Client.new(source, target).verified?
    end
  end
end
