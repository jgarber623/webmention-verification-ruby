# frozen_string_literal: true

RSpec.describe Webmention::Verification, '.verified?' do
  let(:source) { 'https://source.example.com/no-mention' }
  let(:target) { 'https://target.example.com/post/100' }

  context 'when source does not mention target' do
    subject(:verification) { described_class.verified?(source, target) }

    before do
      stub_request(:get, source).to_return(
        headers: { 'Content-Type': 'text/plain' },
        body: read_fixture(source, 'txt')
      )
    end

    it { is_expected.to be(false) }
  end
end
