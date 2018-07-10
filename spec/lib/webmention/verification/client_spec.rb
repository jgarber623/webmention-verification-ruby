describe Webmention::Verification::Client do
  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }

  context 'when source is invalid' do
    it 'raises an ArgumentError when not a String' do
      message = 'source must be a String (given NilClass)'

      expect { described_class.new(nil, target) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end

    it 'raises an InvalidURIError when an invalid URI' do
      expect { described_class.new('https:', target) }.to raise_error(Webmention::Verification::InvalidURIError)
    end

    it 'raises an ArgumentError when not an absolute URI' do
      message = 'source must be an absolute URI (e.g. https://example.com/post/100)'

      expect { described_class.new('/', target) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end
  end

  context 'when target is invalid' do
    it 'raises an ArgumentError when not a String' do
      message = 'target must be a String (given NilClass)'

      expect { described_class.new(source, nil) }.to raise_error(Webmention::Verification::ArgumentError, message)
    end

    it 'raises an InvalidURIError when an invalid URI' do
      expect { described_class.new(source, 'https:') }.to raise_error(Webmention::Verification::InvalidURIError)
    end

    it 'raises an ArgumentError when not an absolute URI' do
      message = 'target must be an absolute URI (e.g. https://example.com/post/100)'

      expect { described_class.new(source, '/') }.to raise_error(Webmention::Verification::ArgumentError, message)
    end
  end

  describe '.response' do
    let(:client) { described_class.new(source, target) }
    let(:request) { stub_request(:get, source) }

    context 'when rescuing an HTTP::ConnectionError' do
      before do
        request.to_raise(HTTP::ConnectionError)
      end

      it 'raises a ConnectionError' do
        expect { client.response }.to raise_error(Webmention::Verification::ConnectionError)
      end
    end

    context 'when rescuing an HTTP::TimeoutError' do
      before do
        request.to_raise(HTTP::TimeoutError)
      end

      it 'raises a TimeoutError' do
        expect { client.response }.to raise_error(Webmention::Verification::TimeoutError)
      end
    end

    context 'when rescuing an HTTP::Redirector::TooManyRedirectsError' do
      before do
        request.to_raise(HTTP::Redirector::TooManyRedirectsError)
      end

      it 'raises a TooManyRedirectsError' do
        expect { client.response }.to raise_error(Webmention::Verification::TooManyRedirectsError)
      end
    end
  end

  describe '.verified?' do
    let :http_response_headers do
      { 'Content-Type': 'unsupported/type' }
    end

    before do
      stub_request(:get, source).to_return(headers: http_response_headers)
    end

    context 'when response MIME type is unsupported/type' do
      it 'raises an UnsupportedMimeTypeError' do
        message = 'Unsupported MIME Type: unsupported/type'

        expect { described_class.new(source, target).verified? }.to raise_error(Webmention::Verification::UnsupportedMimeTypeError, message)
      end
    end
  end
end
