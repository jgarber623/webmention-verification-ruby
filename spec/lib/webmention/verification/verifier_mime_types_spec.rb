describe Webmention::Verification::Verifier, '.mime_types' do
  let(:mime_types) { ['application/json', 'text/html', 'text/plain'] }

  it 'returns an array' do
    expect(described_class.mime_types).to match_array(mime_types)
  end
end
