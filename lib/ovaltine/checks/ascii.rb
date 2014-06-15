
module Ovaltine
  module Check
    module AsciiCheck
      def self.check(str)
        encoding_options = {
          :invalid           => :replace,  # Replace invalid byte sequences
          :undef             => :replace,  # Replace anything not defined in ASCII
          :replace           => '',        # Use a blank for those replacements
        }
        ascii_str = str.encode(Encoding.find('ASCII'), encoding_options)

        return ascii_str == str
      end
    end
  end
end
