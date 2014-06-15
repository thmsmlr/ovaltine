require "base64"

module Ovaltine
  module Decoder
    module Base64
      def self.decode(str)
        ::Base64.decode64(str)
      end
    end
  end
end

