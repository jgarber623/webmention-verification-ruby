# frozen_string_literal: true

module FixtureHelpers
  def read_fixture(uri, format = 'html')
    matches = uri.match(%r{^https?://(?<domain>.*?\..*?\.com)(?<path>.*)$})

    File.read(File.join(Dir.pwd, 'spec', 'support', 'fixtures', matches['domain'], format, "#{matches['path']}.#{format}"))
  end
end
