require 'gscraper/search/result'

module GScraper
  module Search
    class Page < Array

      #
      # Creates a new Page object with the given _results_.
      #
      def initialize(results=[])
        super(results)
      end

      #
      # Returns a mapped Array of the results within the Page using the
      # given _block_. If the _block_ is not given, the page will be
      # returned.
      #
      #   page.map # => Page
      #
      #   page.map { |result| result.url } # => [...]
      #
      def map(&block)
        return self unless block

        mapped = []

        each { |result| mapped << block.call(result) }
        return mapped
      end

      #
      # Selects the results within the Page which match the given _block_.
      #
      #   page.select { |result| result.title =~ /ruby/i }
      #
      def select(&block)
        Page.new(super(&block))
      end

      #
      # Selects the results using the specified _block_.
      #
      #   page.results_with { |result| result.title =~ /blog/ }
      #
      def results_with(&block)
        select(&block)
      end

      #
      # Selects the results with the matching _title_. The _title_ may be
      # either a String or a Regexp. If _block_ is given, each matching
      # result will be passed to the _block_.
      #
      #   page.results_with_title('hackety org') #=> Page
      #
      #   page.results_with_title(/awesome/) do |result|
      #     puts result.url
      #   end
      #
      def results_with_title(title,&block)
        if title.kind_of?(Regexp)
          results = results_with { |result| result.title =~ title }
        else
          results = results_with { |result| result.title == title }
        end

        results.each(&block) if block
        return results
      end

      #
      # Selects the results with the matching _url_. The _url_ may be
      # either a String or a Regexp. If _block_ is given, each matching
      # result will be passed to the _block_.
      #
      #   page.results_with_url(/\.com/) # => Page
      #
      #   page.results_with_url(/^https:\/\//) do |result|
      #     puts result.title
      #   end
      #
      def results_with_url(url,&block)
        if url.kind_of?(Regexp)
          results = results_with { |result| result.url =~ url }
        else
          results = results_with { |result| result.url == url }
        end

        results.each(&block) if block
        return results
      end

      #
      # Selects the results with the matching _summary_. The _summary_ may
      # be either a String or a Regexp. If _block_ is given, each matching
      # result will be passed to the _block_.
      #
      #   page.results_with_summary(/cheese cake/) # => Page
      #
      #   page.results_with_summary(/Scientifically/) do |result|
      #     puts result.url
      #   end
      #
      def results_with_summary(summary,&block)
        if summary.kind_of?(Regexp)
          results = results_with { |result| result.summary =~ summary }
        else
          results = results_with { |result| result.summary == summary }
        end

        results.each(&block) if block
        return results
      end

      #
      # Returns an Array containing the ranks of the results within the
      # Page.
      #
      #   page.ranks # => [...]
      #
      #   page.ranks do |rank|
      #     puts ranks
      #   end
      #
      def ranks
        map { |result| result.rank }
      end

      #
      # Returns an Array containing the titles of the results within the
      # Page.
      #
      #   page.titles # => [...]
      #
      #   page.titles do |title|
      #     puts title
      #   end
      #
      def titles
        map { |result| result.title }
      end

      #
      # Returns an Array containing the URLs of the results within the
      # Page.
      #
      #   page.urls # => [...]
      #
      #   page.urls do |url|
      #     puts url
      #   end
      #
      def urls
        map { |result| result.url }
      end

      #
      # Returns an Array containing the summaries of the results within the
      # Page.
      #
      #   page.summaries # => [...]
      #
      #   page.summaries do |summary|
      #     puts summary
      #   end
      #
      def summaries
        map { |result| result.summary }
      end

      #
      # Iterates over each result's rank within the Page, passing each to
      # the given _block_.
      #
      #   each_rank { |rank| puts rank }
      #
      def each_rank(&block)
        ranks.each(&block)
      end

      #
      # Iterates over each result's title within the Page, passing each to
      # the given _block_.
      #
      #   each_title { |title| puts title }
      #
      def each_title(&block)
        titles.each(&block)
      end

      #
      # Iterates over each result's url within the Page, passing each to
      # the given _block_.
      #
      #   each_url { |url| puts url }
      #
      def each_url(&block)
        urls.each(&block)
      end

      #
      # Iterates over each result's summary within the Page, passing each
      # to the given _block_.
      #
      #   each_summary { |summary| puts summary }
      #
      def each_summary(&block)
        summaries.each(&block)
      end

      #
      # Returns the ranks of the results that match the specified _block_.
      #
      #   page.ranks_of { |result result.title =~ /awesome/ }
      #
      def ranks_of(&block)
        results_with(&block).ranks
      end

      #
      # Returns the titles of the results that match the specified _block_.
      #
      #   page.titles_of { |result result.url.include?('www') }
      #
      def titles_of(&block)
        results_with(&block).titles
      end

      #
      # Returns the urls of the results that match the specified _block_.
      #
      #   page.urls_of { |result result.summary =~ /awesome pants/ }
      #
      def urls_of(&block)
        results_with(&block).urls
      end

      #
      # Returns the summaries of the results that match the specified
      # _block_.
      #
      #   page.summaries_of { |result result.title =~ /what if/ }
      #
      def summaries_of(&block)
        results_with(&block).summaries
      end

    end
  end
end
