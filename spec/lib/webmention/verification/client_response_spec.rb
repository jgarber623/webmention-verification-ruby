# frozen_string_literal: true

RSpec.describe Webmention::Verification::Client, '#response' do
  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }

  context 'when rescuing an HTTP::Error' do
    before do
      stub_request(:get, source).to_raise(HTTP::Error)
    end

    it 'raises an HttpError' do
      expect { described_class.new(source, target).response }.to raise_error(Webmention::Verification::HttpError)
    end
  end
end
