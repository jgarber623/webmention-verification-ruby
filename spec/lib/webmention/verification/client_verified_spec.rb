describe Webmention::Verification::Client, '.verified?' do
  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }
  let(:client) { described_class.new(source, target) }

  let :http_response_headers do
    { 'Content-Type': 'text/plain' }
  end

  before do
    stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, 'txt'))
  end

  context 'when response MIME type is unsupported' do
    let :http_response_headers do
      { 'Content-Type': 'unsupported/type' }
    end

    it 'raises an UnsupportedMimeTypeError' do
      message = 'Unsupported MIME Type: unsupported/type'

      expect { client.verified? }.to raise_error(Webmention::Verification::UnsupportedMimeTypeError, message)
    end
  end

  context 'when in strict mode' do
    context 'when schemes do not match' do
      let(:source) { 'https://source.example.com/source_mentions_target_absolute_url_http' }

      it 'returns false' do
        expect(client.verified?).to be(false)
      end
    end

    context 'when schemes match' do
      let(:source) { 'https://source.example.com/source_mentions_target_absolute_url_https' }

      it 'returns true' do
        expect(client.verified?).to be(true)
      end
    end

    context 'when source mentions similar target' do
      let(:source) { 'https://source.example.com/source_mentions_similar_absolute_url_https' }

      it 'returns false' do
        expect(client.verified?).to be(false)
      end
    end
  end

  context 'when not in strict mode' do
    let(:client) { described_class.new(source, target, strict: false) }

    context 'when schemes do not match' do
      let(:source) { 'https://source.example.com/source_mentions_target_absolute_url_http' }

      it 'returns true' do
        expect(client.verified?).to be(true)
      end
    end

    context 'when schemes match' do
      let(:source) { 'https://source.example.com/source_mentions_target_absolute_url_https' }

      it 'returns true' do
        expect(client.verified?).to be(true)
      end
    end

    context 'when source mentions similar target' do
      let(:source) { 'https://source.example.com/source_mentions_similar_absolute_url_http' }

      it 'returns false' do
        expect(client.verified?).to be(false)
      end
    end
  end
end
