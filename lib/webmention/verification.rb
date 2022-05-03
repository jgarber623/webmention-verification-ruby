# frozen_string_literal: true

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
    # Determine whether or not source URI links to target URI.
    #
    # @example
    #   source = 'https://source.example.com/post/100'
    #   target = 'https://target.example.com/post/100'
    #
    #   puts Webmention::Verification.verified?(source, target)
    #   #=> TrueClass or FalseClass
    #
    # @param source [String]
    # @param target [String]
    # @param options [Hash]
    # @option options [Boolean] :strict (true)
    # @return [Boolean]
    def self.verified?(source, target, **options)
      Client.new(source, target, **options).verified?
    end
  end
end
