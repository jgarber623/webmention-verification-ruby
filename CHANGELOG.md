# Changelog

## 6.0.0 / 2022-05-03

- Move/rename BaseVerifier to Verifier class (6965e98)
- Remove addressable dependency (38a004e)
- Raise Webmention::Verification::SSLError on SSL errors (be9d922)
- Update ~~Addressable and~~ Nokogiri dependency constraints (822b7ae)
- **Breaking change:** Update minimum supported Ruby to 2.6 (07a7c5e)
- Update development Ruby version to 2.6.10 (d67d583)
- Remove Reek (b10b648)

## 5.0.0 / 2021-06-08

- Add `Webmention::Verification::Client#inspect` method (361c437)
- Update [HTTP](https://github.com/httprb/http) gem constraint to ~> 5.0 (4063764)
- Simplify exception handling (3f8f12c)
- Rename base `WebmentionVerificationError` class to `Error` (2b12338)
- Add support for Ruby 3.0 (05baf08)
- Update development Ruby version to 2.5.9 (821a488)

## 4.0.0 / 2020-08-23

- **Breaking Change:** Update minimum supported Ruby version to 2.5 (096012e)
- Update development Ruby version to 2.5.8 (3b3f38e)

## 3.0.0 / 2020-05-14

- **Breaking Change:** Remove `Webmention::Verification.client` convenience method (af575d7)
- **Breaking Change:** Remove `HttpRequest` class (112f9d3)
- Move development dependencies to `Gemfile` (81cdfdf)
- Update development Ruby version to 2.4.10 (a13bca0)

## 2.0.0 / 2020-01-25

- Downgrade [HTTP](https://github.com/httprb/http) gem constraint to ~> 4.3 (090f590)

## 1.2.0 / 2020-01-20

- Expand supported Ruby versions to include 2.7 (48d9b7b)

## 1.1.1 / 2019-08-31

- Update Addressable gem (0c9368e)
- Update development dependencies

## 1.1.0 / 2019-05-01

- Add `Webmention::Verification.client` method
- Rename base `Error` class to `WebmentionVerificationError` (0eb3a9a)
- Add `HttpRequest` class (c7602c9)

## 1.0.0 / 2019-04-25

- Use pre-release HTTP gem (see @httprb/http#489) (bdcfdad)
- Refactor verifiers (7eef7bd, 55eb17e, bcdf3b4)
- Refactor `Client#response` exception handling (29afcb0)
- Rename `errors` to `exceptions` (2bca96b)
- Spec cleanup (4b84f16, 4940e9c)

## 0.1.2 / 2019-01-03

- Expand supported Ruby versions to include 2.6 (1d61fea)

## 0.1.1 / 2018-11-11

- Liberalize gemspec dependency constraints (063c7f1)

## 0.1.0 / 2018-07-11

- Initial release!
