module Ovaltine
  module Decoder
    (1..25).each do |num|
      mod = Module.new
      mod.define_singleton_method(:decode) { |str|
        str.split("").collect { |ch|
          if /^[a-z]$/ === ch
            ((ch.ord + num - 'a'.ord) % 26 + 'a'.ord).chr
          elsif /^[A-Z]$/ === ch
            ((ch.ord + num - 'A'.ord) % 26 + 'A'.ord).chr
          else
            ch
          end
        }.join("")
      }
      Ovaltine::Decoder.const_set("Rot#{num}".to_sym, mod)
    end
  end
end
