
module Ovaltine
  module Decoder
    def self.all_decoders
      self.constants.collect { |c|
        self.const_get(c)
      }.select { |c| c.is_a? Module }
    end

    def self.find_encoding(encoded_str, decoders, checks, depth=3)
      depth = [decoders.length, depth].min
      (1..depth).map { |num|
        decoders.permutation(num).to_a
      }.flatten(1).map { |perm|
        Ovaltine::DecoderChain.new(perm)
      }.select { |chain|
        decoded_str = chain.decode(encoded_str)
        checks.all? { |check| check.check(decoded_str) }
      }
    end
  end

  class DecoderChain
    def initialize(decoders)
      @decoders = decoders
    end

    def name
      @decoders.collect { |d| d.name.split("::")[-1] }.join("->")
    end

    def decode(str)
      @decoders.inject(str) { |str, d| d.decode(str) }
    end
  end
end
