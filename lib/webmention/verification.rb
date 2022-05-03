# frozen_string_literal: true

require 'json'

require 'addressable/uri'
require 'http'
require 'nokogiri'

require_relative 'verification/version'

require_relative 'verification/client'
require_relative 'verification/verifiers'
require_relative 'verification/verifiers/base_verifier'
require_relative 'verification/verifiers/html_verifier'
require_relative 'verification/verifiers/json_verifier'
require_relative 'verification/verifiers/plaintext_verifier'

module Webmention
  module Verification
    class Error < StandardError; end
    class ArgumentError < Error; end
    class HttpError < Error; end
    class InvalidURIError < Error; end
    class SSLError < Error; end
    class UnsupportedMimeTypeError < Error; end

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
