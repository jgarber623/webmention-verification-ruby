describe Webmention::Verification::Client, '.verified?' do
  context 'when response MIME type is text/html' do
    let(:file_format) { 'html' }

    let :http_response_headers do
      { 'Content-Type': 'text/html' }
    end

    it_behaves_like 'when in strict mode'
    it_behaves_like 'when in strict mode testing extended element matching'
    it_behaves_like 'when not in strict mode'
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
