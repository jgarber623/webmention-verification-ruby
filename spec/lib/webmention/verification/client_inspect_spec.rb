# frozen_string_literal: true

RSpec.describe Webmention::Verification::Client, '#inspect' do
  subject(:inspection) { described_class.new(source, target).inspect }

  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }

  it { is_expected.to match(/^#<#{described_class}:0x[a-f0-9]+ source: "#{source}" target: "#{target}"/) }
end
