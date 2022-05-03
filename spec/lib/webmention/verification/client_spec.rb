# frozen_string_literal: true

RSpec.describe Webmention::Verification::Client do
  let(:source) { 'https://source.example.com' }
  let(:target) { 'https://target.example.com/post/100' }

  context 'when source is not a String-like object' do
    it 'raises a NoMethodError' do
      expect { described_class.new(nil, target) }.to raise_error(NoMethodError)
    end
  end

  context 'when source is invalid' do
    it 'raises an InvalidURIError when an invalid URI' do
      expect { described_class.new('https:', target) }.to raise_error(Webmention::Verification::InvalidURIError)
    end

    it 'raises an ArgumentError when not an absolute URI' do
      expect { described_class.new('/', target) }.to raise_error(
        Webmention::Verification::ArgumentError, 'source must be an absolute URI (e.g. https://example.com/post/100)'
      )
    end
  end

  context 'when target is not a String-like object' do
    it 'raises a NoMethodError' do
      expect { described_class.new(source, nil) }.to raise_error(NoMethodError)
    end
  end

  context 'when target is invalid' do
    it 'raises an InvalidURIError when an invalid URI' do
      expect { described_class.new(source, 'https:') }.to raise_error(Webmention::Verification::InvalidURIError)
    end

    it 'raises an ArgumentError when not an absolute URI' do
      expect { described_class.new(source, '/') }.to raise_error(
        Webmention::Verification::ArgumentError, 'target must be an absolute URI (e.g. https://example.com/post/100)'
      )
    end
  end
end
