describe Webmention::Verification::Verifier do
  let(:response) { instance_double(HTTP::Response, is_a?: true, mime_type: 'text/plain') }
  let(:target) { 'https://target.example.com/post/100' }

  context 'when response is invalid' do
    it 'raises an ArgumentError' do
      message = 'response must be an HTTP::Response (given NilClass)'

      expect { described_class.new(nil, target) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end

    it 'raises an UnsupportedMimeTypeError' do
      message = 'Unsupported MIME Type: unsupported/type'

      allow(response).to receive(:mime_type).and_return('unsupported/type')

      expect { described_class.new(response, target) }.to raise_error(Webmention::Verification::UnsupportedMimeTypeError, message)
    end
  end

  context 'when target is invalid' do
    it 'raises an ArgumentError' do
      message = 'target must be a String (given NilClass)'

      expect { described_class.new(response, nil) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end
  end
end
