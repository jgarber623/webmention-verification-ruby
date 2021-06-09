module Webmention
  module Verification
    class Error < StandardError; end

    class ArgumentError < Error; end

    class HttpError < Error; end

    class InvalidURIError < Error; end

    class UnsupportedMimeTypeError < Error; end
  end
end
