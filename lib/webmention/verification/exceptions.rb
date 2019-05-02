module Webmention
  module Verification
    class WebmentionVerificationError < StandardError; end

    class ArgumentError < WebmentionVerificationError; end

    class ConnectionError < WebmentionVerificationError; end

    class InvalidURIError < WebmentionVerificationError; end

    class TimeoutError < WebmentionVerificationError; end

    class TooManyRedirectsError < WebmentionVerificationError; end

    class UnsupportedMimeTypeError < WebmentionVerificationError; end
  end
end
