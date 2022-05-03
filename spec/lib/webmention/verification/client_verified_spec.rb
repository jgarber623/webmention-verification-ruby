# frozen_string_literal: true

RSpec.describe Webmention::Verification::Client, '#verified?' do
  context 'when response MIME type is unsupported/type' do
    let(:source) { 'https://source.example.com' }
    let(:target) { 'https://target.example.com/post/100' }

    before do
      stub_request(:get, source).to_return(headers: { 'Content-Type': 'unsupported/type' })
    end

    it 'raises an UnsupportedMimeTypeError' do
      expect { described_class.new(source, target).verified? }.to raise_error(
        Webmention::Verification::UnsupportedMimeTypeError, 'Unsupported MIME Type: unsupported/type'
      )
    end
  end

  context 'when response MIME type is application/json' do
    let(:file_format) { 'json' }

    let(:http_response_headers) do
      { 'Content-Type': 'application/json' }
    end

    it_behaves_like 'strict mode is true'
    it_behaves_like 'strict mode is false'

    %w[array hash].each do |obj|
      context "when deep value matching #{obj}" do
        subject(:verification) { described_class.new(source, target, strict: false).verified? }

        let(:source) { "https://source.example.com/mentions-target-absolute-url-deep-#{obj}" }
        let(:target) { 'https://target.example.com/post/100' }

        before do
          stub_request(:get, source).to_return(
            headers: http_response_headers,
            body: read_fixture(source, file_format)
          )
        end

        it { is_expected.to be(true) }
      end
    end
  end

  context 'when response MIME type is text/html' do
    let(:file_format) { 'html' }

    let :http_response_headers do
      { 'Content-Type': 'text/html' }
    end

    it_behaves_like 'strict mode is true'
    it_behaves_like 'strict mode is false'

    %w[
      area audio blockquote del embed img-src img-srcset ins
      object q source-src source-srcset video-track video
    ].each do |element|
      context "when matching #{element}" do
        subject(:verification) { described_class.new(source, target, strict: false).verified? }

        let(:source) { "https://source.example.com/mentions-target-absolute-url-#{element}" }
        let(:target) { 'https://target.example.com/post/100' }

        before do
          stub_request(:get, source).to_return(
            headers: http_response_headers,
            body: read_fixture(source, file_format)
          )
        end

        it { is_expected.to be(true) }
      end
    end
  end

  context 'when response MIME type is text/plain' do
    let(:file_format) { 'txt' }

    let :http_response_headers do
      { 'Content-Type': 'text/plain' }
    end

    it_behaves_like 'strict mode is true'
    it_behaves_like 'strict mode is false'
  end
end
