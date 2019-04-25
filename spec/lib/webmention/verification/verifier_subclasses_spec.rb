describe Webmention::Verification::Verifier, '.subclasses' do
  let :subclasses do
    [
      Webmention::Verification::HtmlVerifier,
      Webmention::Verification::JsonVerifier,
      Webmention::Verification::PlaintextVerifier
    ]
  end

  it 'returns an array' do
    expect(described_class.subclasses).to match_array(subclasses)
  end
end
