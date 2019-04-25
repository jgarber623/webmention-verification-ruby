describe Webmention::Verification::Client, '#response' do
  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }

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
