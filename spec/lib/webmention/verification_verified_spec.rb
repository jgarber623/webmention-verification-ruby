describe Webmention::Verification, '.verified?' do
  let(:source) { 'https://source.example.com/no-mention' }
  let(:target) { 'https://target.example.com/post/100' }

  let(:http_response_headers) do
    { 'Content-Type': 'text/plain' }
  end

  context 'when source does not mention target' do
    before do
      stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, 'txt'))
    end

    it 'returns false' do
      expect(described_class.verified?(source, target)).to be(false)
    end
  end
end
