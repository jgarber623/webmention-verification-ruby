# frozen_string_literal: true

RSpec.shared_examples 'when in strict mode' do
  let(:target) { 'https://target.example.com/post/100' }
  let(:client) { described_class.new(source, target) }

  before do
    stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, file_format))
  end

  context 'when schemes do not match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-http' }

    it 'returns false' do
      expect(client.verified?).to be(false)
    end
  end

  context 'when schemes match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-https' }

    it 'returns true' do
      expect(client.verified?).to be(true)
    end
  end

  context 'when source mentions similar target' do
    let(:source) { 'https://source.example.com/mentions-similar-absolute-url-https' }

    it 'returns false' do
      expect(client.verified?).to be(false)
    end
  end
end

RSpec.shared_examples 'when not in strict mode' do
  let(:target) { 'https://target.example.com/post/100' }
  let(:client) { described_class.new(source, target, strict: false) }

  before do
    stub_request(:get, source).to_return(headers: http_response_headers, body: read_fixture(source, file_format))
  end

  context 'when schemes do not match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-http' }

    it 'returns true' do
      expect(client.verified?).to be(true)
    end
  end

  context 'when schemes match' do
    let(:source) { 'https://source.example.com/mentions-target-absolute-url-https' }

    it 'returns true' do
      expect(client.verified?).to be(true)
    end
  end

  context 'when source mentions similar target' do
    let(:source) { 'https://source.example.com/mentions-similar-absolute-url-http' }

    it 'returns false' do
      expect(client.verified?).to be(false)
    end
  end
end
