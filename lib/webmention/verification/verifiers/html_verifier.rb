module Webmention
  module Verification
    class HtmlVerifier < Verifier
      HTML_ATTRIBUTE_MAPPINGS = {
        cite:   %w[blockquote del ins q],
        data:   %w[object],
        href:   %w[a area],
        poster: %w[video],
        src:    %w[audio embed img source track video],
        srcset: %w[img source]
      }.freeze

      def self.mime_types
        ['text/html']
      end

      private

      def doc
        @doc ||= Nokogiri::HTML(response_body)
      end

      def parse_response_body
        matches = []

        HTML_ATTRIBUTE_MAPPINGS.each do |attribute, elements|
          elements.each { |element| matches << search_doc(element, attribute) }
        end

        matches.flatten
      end

      def search_doc(element, attribute)
        regexp = attribute == :srcset ? srcset_attribute_regexp : target_regexp

        doc.css("#{element}[#{attribute}]").find_all { |node| node[attribute].match?(regexp) }
      end

      def srcset_attribute_regexp
        /(?:^|\b)#{target_regexp_str}\s/
      end

      def target_regexp
        /^#{target_regexp_str}$/
      end
    end
  end
end
