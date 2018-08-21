describe Webmention::Verification::Client, '#verified?' do
  context 'when response MIME type is application/json' do
    let(:file_format) { 'json' }

    let :http_response_headers do
      { 'Content-Type': 'application/json' }
    end

    it_behaves_like 'when in strict mode'
    it_behaves_like 'when not in strict mode'

    context 'when in strict mode testing deep value matching' do
      let(:target) { 'https://target.example.com/post/100' }
      let(:client) { described_class.new(source, target, strict: false) }

      before do
        stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, file_format))
      end

      %w[array hash].each do |obj|
        context "when matching #{obj}" do
          let(:source) { "https://source.example.com/mentions-target-absolute-url-deep-#{obj}" }

          it 'returns true' do
            expect(client.verified?).to be(true)
          end
        end
      end
    end
  end

  context 'when response MIME type is text/html' do
    let(:file_format) { 'html' }

    let :http_response_headers do
      { 'Content-Type': 'text/html' }
    end

    it_behaves_like 'when in strict mode'
    it_behaves_like 'when not in strict mode'

    context 'when in strict mode testing extended element matching' do
      let(:target) { 'https://target.example.com/post/100' }
      let(:client) { described_class.new(source, target, strict: false) }

      before do
        stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, file_format))
      end

      %w[area audio blockquote del embed img-src img-srcset ins object q source-src source-srcset video-track video].each do |element|
        context "when matching #{element}" do
          let(:source) { "https://source.example.com/mentions-target-absolute-url-#{element}" }

          it 'returns true' do
            expect(client.verified?).to be(true)
          end
        end
      end
    end
  end

  context 'when response MIME type is text/plain' do
    let(:file_format) { 'txt' }

    let :http_response_headers do
      { 'Content-Type': 'text/plain' }
    end

    it_behaves_like 'when in strict mode'
    it_behaves_like 'when not in strict mode'
  end
end
