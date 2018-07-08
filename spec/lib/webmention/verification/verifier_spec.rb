describe Webmention::Verification::Verifier do
  let(:response) { instance_double(HTTP::Response, is_a?: true, mime_type: 'text/plain') }
  let(:target_uri) { instance_double(Addressable::URI) }

  context 'when response is invalid' do
    it 'raises an ArgumentError' do
      message = 'response must be an HTTP::Response (given String)'

      expect { described_class.new(response: '', target_uri: target_uri) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end

    it 'raises an UnsupportedMimeTypeError' do
      message = 'Unsupported MIME Type: unsupported/type'

      allow(response).to receive(:mime_type).and_return('unsupported/type')

      expect { described_class.new(response: response, target_uri: target_uri) }.to raise_error(Webmention::Verification::UnsupportedMimeTypeError, message)
    end
  end

  context 'when target_uri is invalid' do
    it 'raises an ArgumentError' do
      message = 'target_uri must be an Addressable::URI (given String)'

      expect { described_class.new(response: response, target_uri: '') }.to raise_error(Webmention::Verification::ArgumentError, message)
    end
  end

  it 'returns an array of supported mime types' do
    mime_types = ['application/json', 'text/plain']

    expect(described_class.mime_types).to match_array(mime_types)
  end

  it 'returns an array of subclasses' do
    subclasses = [Webmention::Verification::JsonVerifier, Webmention::Verification::PlaintextVerifier]

    expect(described_class.subclasses).to match_array(subclasses)
  end
end
