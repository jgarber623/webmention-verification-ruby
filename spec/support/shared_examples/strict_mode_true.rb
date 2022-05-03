# frozen_string_literal: true

RSpec.shared_examples 'strict mode is true' do
  subject(:verification) { described_class.new(source, target).verified? }

  let(:target) { 'https://target.example.com/post/100' }

  before do
    stub_request(:get, source).to_return(
      headers: http_response_headers,
      body: read_fixture(source, file_format)
    )
  end

  context 'when schemes do not match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-http' }

    it { is_expected.to be(false) }
  end

  context 'when schemes match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-https' }

    it { is_expected.to be(true) }
  end

  context 'when source mentions similar target' do
    let(:source) { 'https://source.example.com/mentions-similar-absolute-url-https' }

    it { is_expected.to be(false) }
  end
end
