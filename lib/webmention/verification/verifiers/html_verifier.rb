# frozen_string_literal: true

module Webmention
  module Verification
    module Verifiers
      class HtmlVerifier < BaseVerifier
        @mime_types = ['text/html']

        Verifiers.register(self)

        HTML_ATTRIBUTE_MAP = {
          cite:   %w[blockquote del ins q],
          data:   %w[object],
          href:   %w[a area],
          poster: %w[video],
          src:    %w[audio embed img source track video],
          srcset: %w[img source]
        }.freeze

        private

        def doc
          @doc ||= Nokogiri::HTML(response_body)
        end

        def parse_response_body
          HTML_ATTRIBUTE_MAP.each_with_object([]) { |(*args), matches| matches << search_doc(*args) }.flatten
        end

        def search_doc(attribute, elements)
          regexp = attribute == :srcset ? srcset_attribute_regexp : target_regexp

          doc.css(*elements.map { |element| "#{element}[#{attribute}]" }).find_all do |node|
            node[attribute].match?(regexp)
          end
        end

        def srcset_attribute_regexp
          @srcset_attribute_regexp ||= /(?:^|\b)#{target_regexp_str}\s/
        end
      end
    end
  end
end
