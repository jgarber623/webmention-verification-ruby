# webmention-verification-ruby

**A Ruby gem for verifying a received [Webmention](https://indieweb.org/Webmention).**

[![Gem](https://img.shields.io/gem/v/webmention-verification.svg?style=for-the-badge)](https://rubygems.org/gems/webmention-verification)
[![Downloads](https://img.shields.io/gem/dt/webmention-verification.svg?style=for-the-badge)](https://rubygems.org/gems/webmention-verification)
[![Build](https://img.shields.io/travis/com/jgarber623/webmention-verification-ruby/master.svg?style=for-the-badge)](https://travis-ci.com/jgarber623/webmention-verification-ruby)
[![Dependencies](https://img.shields.io/depfu/jgarber623/webmention-verification-ruby.svg?style=for-the-badge)](https://depfu.com/github/jgarber623/webmention-verification-ruby)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/jgarber623/webmention-verification-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/webmention-verification-ruby)
[![Coverage](https://img.shields.io/codeclimate/c/jgarber623/webmention-verification-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/webmention-verification-ruby/code)

## Key Features

- **Coming soon!** Compliant with [Section 3.2.2](https://www.w3.org/TR/webmention/#webmention-verification) of [the W3C's Webmention spcification](https://www.w3.org/TR/webmention/).
- Supports Ruby 2.4 and newer.

## Getting Started

Before installing and using webmention-verification-ruby, you'll want to have [Ruby](https://www.ruby-lang.org) 2.4 (or newer) installed. It's recommended that you use a Ruby version managment tool like [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), or [rvm](https://github.com/rvm/rvm).

webmention-verification-ruby is developed using Ruby 2.4.4 and is additionally tested against Ruby 2.5.1 using [Travis CI](https://travis-ci.com/jgarber623/webmention-verification-ruby).

## Installation

If you're using [Bundler](https://bundler.io), add webmention-verification-ruby to your project's `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'webmention-verification'
```

…and hop over to your command prompt and run…

```sh
$ bundle install
```

## Usage

### Basic Usage

With webmention-verification-ruby added to your project's `Gemfile` and installed, you may verify a received Webmention by doing:

```ruby
require 'webmention/verification'

source = 'https://source.example.com/post/100'
target = 'https://target.example.com/post/100'

verified = Webmention::Verification.verified?(source, target)

puts verified # returns Boolean
```

This example assumes that you've received a Webmention from `https://source.example.com/post/100` (the "source") to your URL, `https://target.example.com/post/100` (the "target"). The above code will return `true` if the source URL links to your target URL and `fase` if it doesn't.

### Advanced Usage

Should the need arise, you may work directly with the `Webmention::Verification::Client` class:

```ruby
require 'webmention/verification'

source = 'https://source.example.com/post/100'
target = 'https://target.example.com/post/100'

client = Webmention::Verification::Client.new(source, target)

puts client.source     # returns String: 'https://source.example.com/post/100'
puts client.target     # returns String: 'https://target.example.com/post/100'

puts client.source_uri # returns Addressable::URI
puts client.target_uri # returns Addressable::URI

puts client.response   # returns HTTP::Response

puts client.verified?  # Returns Boolean
```

**By default, webmention-verification-ruby will strictly match URLs.** You may disable strict matching which allows webmention-verification-ruby to match both `http://` and `https://` URLs. This is useful for matching Webmentions your website may have received before upgrading your website to use HTTPS.

To disable strict mode, pass `strict: false` when instantiating a `Webmention::Verification::Client`:

```ruby
require 'webmention/verification'

source = 'https://source.example.com/post/100'
target = 'https://target.example.com/post/100'

client = Webmention::Verification::Client.new(source, target, strict: false)

puts client.verified?  # Returns Boolean
```

The above example will match either `https://source.example.com/post/100` _or_ `http://source.example.com/post/100` in the target URL.

### Exception Handling

There are several exceptions that may be raised by webmention-verification-ruby's underlying dependencies. These errors are raised as subclasses of `Webmention::Verification::Error` (which itself is a subclass of `StandardError`).

From [sporkmonger/addressable](https://github.com/sporkmonger/addressable):

- `Webmention::Verification::InvalidURIError`

From [httprb/http](https://github.com/httprb/http):

- `Webmention::Verification::ConnectionError`
- `Webmention::Verification::TimeoutError`
- `Webmention::Verification::TooManyRedirectsError`

webmention-verification-ruby will also raise a `Webmention::Verification::UnsupportedMimeTypeError` when encountering an `HTTP::Response` instance with an unsupported MIME type.

## Contributing

Interested in helping improve webmention-verification-ruby? Awesome! Your help is greatly appreciated. See [CONTRIBUTING.md](https://github.com/jgarber623/webmention-verification-ruby/blob/master/CONTRIBUTING.md) for details.

## Acknowledgments

webmention-verification-ruby wouldn't exist without Webmention and the hard work put in by everyone involved in the [IndieWeb](https://indieweb.org) movement. Additionally, the [LinkExtractor class](https://github.com/Zegnat/php-linkextractor/blob/master/src/LinkExtractor.php#L32-L51) in [Zegnat](https://github.com/Zegnat)'s [php-linkextractor](https://github.com/Zegnat/php-linkextractor) was invaluable in the devleopment of the `HTMLVerifier` class.

webmention-verification-ruby is written and maintained by [Jason Garber](https://sixtwothree.org).

## License

webmention-verification-ruby is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
