require 'bundler/setup'
require 'simplecov'
require 'webmock/rspec'

require 'webmention/verification'

Dir.glob(File.join(Dir.pwd, 'spec', 'support', '**', '*.rb')).sort.each { |f| require f }

RSpec.configure do |config|
  config.include FixtureHelpers

  config.disable_monkey_patching!
end
