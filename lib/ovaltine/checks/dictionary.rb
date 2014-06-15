require "set"

module Ovaltine
  module Check
    module DictionaryCheck
      @@confidence = 15
      @@dictionary = File.read("/usr/share/dict/words").split("\n").to_set()

      def self.add_arguments(opts)
        opts.on("--dictionary-confidence NUM",
                "Confidence percentage that the decoded string is in the dictionary") do |num|
          @@confidence = num.to_i
        end
        opts.on("--dictionary-path PATH",
                "Path to the system dictionary file [default /usr/share/dict/words]") do |path|
          @@dictionary = File.read(path).split("\n").to_set()
        end
      end

      def self.check(str)
        english = str.split(/[^A-Za-z0-9]/).collect do |word|
          @@dictionary.include?(word.downcase)
        end

        tokenized = str.split(/[^A-Za-z0-9]/)
        num_english = tokenized.count { |word| @@dictionary.include?(word.downcase) }
        computed_confidence = (num_english.to_f / tokenized.count) * 100

        return computed_confidence > @@confidence
      end

    end
  end
end
