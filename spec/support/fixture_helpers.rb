module FixtureHelpers
  def read_fixture(uri, format = 'html')
    file_name = "#{uri.gsub(%r{^https?://}, '').gsub(%r{[/.]}, '_')}.#{format}"

    File.read(File.join(Dir.pwd, 'spec', 'support', 'fixtures', file_name))
  end
end
