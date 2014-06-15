require "ovaltine/decoder"

module Ovaltine::Decoder::IdentityDecoder
  def self.decode(encoded_str)
    encoded_str
  end
end

module Ovaltine::Decoder::FakeDecoder
  def self.decode(encoded_str)
    encoded_str
  end
end

module Ovaltine
  describe Decoder do
    context "#all_decoders" do
      it "should return all loaded decoders" do
        decoders = Ovaltine::Decoder.all_decoders
        expect(decoders.length).to be >= 1
        expect(decoders).to include(Ovaltine::Decoder::IdentityDecoder)
      end
    end

    context "#find_encoding" do
      it "should call the decode method an appropriate number of times" do
        decoders = [
          Ovaltine::Decoder::IdentityDecoder,
          Ovaltine::Decoder::FakeDecoder
        ]

        decoders.each do |decoder|
          expect(decoder).to receive(:decode).exactly(3).times
        end

        expect(Ovaltine::Decoder.find_encoding("test", decoders, []).length)
              .to eq(4)
      end

      it "should only permute to the given depth" do
        decoders = [
          Ovaltine::Decoder::IdentityDecoder,
          Ovaltine::Decoder::FakeDecoder
        ]

        decoders.each do |decoder|
          expect(decoder).to receive(:decode).exactly(1).times
        end

        expect(Ovaltine::Decoder.find_encoding("test", decoders, [], depth=1).length)
              .to eq(2)
      end

      it "should return a decoder chain" do
        decoders = [
          Ovaltine::Decoder::IdentityDecoder
        ]

        expect(Ovaltine::Decoder.find_encoding("test", decoders, [])[0])
              .to be_a(Ovaltine::DecoderChain)
      end
    end
  end

  describe DecoderChain do
    context ".name" do
      it "should return name without namespace" do
        chain = Ovaltine::DecoderChain.new([Ovaltine::Decoder::IdentityDecoder])
        expect(chain.name).to eq("IdentityDecoder")
      end

      it "should join decoder names with an arrow" do
        chain = Ovaltine::DecoderChain.new([
          Ovaltine::Decoder::IdentityDecoder,
          Ovaltine::Decoder::FakeDecoder,
        ])

       expect(chain.name).to eq("IdentityDecoder->FakeDecoder")
      end
    end

    context ".decode" do
      it "should call decoders in order" do
        chain = Ovaltine::DecoderChain.new([
          Ovaltine::Decoder::IdentityDecoder,
          Ovaltine::Decoder::FakeDecoder,
        ])

        expect(Ovaltine::Decoder::IdentityDecoder).to receive(:decode).ordered
        expect(Ovaltine::Decoder::FakeDecoder).to receive(:decode).ordered

        chain.decode("test")
      end
    end
  end
end
