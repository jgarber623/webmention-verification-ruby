module Webmention
  module Verification
    class HttpRequest
      HTTP_HEADERS_OPTS = {
        accept:     '*/*',
        user_agent: 'Webmention Verification Client (https://rubygems.org/gems/webmention-verification)'
      }.freeze

      def self.get(uri)
        HTTP.follow.headers(HTTP_HEADERS_OPTS).timeout(connect: 10, read: 10).get(uri)
      rescue HTTP::ConnectionError,
             HTTP::TimeoutError,
             HTTP::Redirector::TooManyRedirectsError => exception
        raise Webmention::Verification.const_get(exception.class.name.split('::').last), exception
      end
    end
  end
end
