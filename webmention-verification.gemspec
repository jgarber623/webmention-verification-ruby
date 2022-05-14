# frozen_string_literal: true

require_relative 'lib/webmention/verification/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.6', '< 4'

  spec.name          = 'webmention-verification'
  spec.version       = Webmention::Verification::VERSION
  spec.authors       = ['Jason Garber']
  spec.email         = ['jason@sixtwothree.org']

  spec.summary       = 'Deprecated in favor of webmention from 2022-05-13. Verify a received webmention.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jgarber623/webmention-verification-ruby'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*'].reject { |f| File.directory?(f) }
  spec.files        += %w[LICENSE CHANGELOG.md CONTRIBUTING.md README.md]
  spec.files        += %w[webmention-verification.gemspec]

  spec.require_paths = ['lib']

  spec.metadata = {
    'bug_tracker_uri'       => "#{spec.homepage}/issues",
    'changelog_uri'         => "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md",
    'rubygems_mfa_required' => 'true'
  }

  spec.post_install_message = <<NOTICE

  +----------------------------------------------------------+
  |                                                          |
  |  webmention-verification is deprecated from 2022-05-13.  |
  |                                                          |
  |  Please use the webmention gem instead.                  |
  |                                                          |
  +----------------------------------------------------------+

NOTICE

  spec.add_runtime_dependency 'http', '~> 5.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.13'
end
