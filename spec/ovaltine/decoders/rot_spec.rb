require "ovaltine/decoders/rot"

describe Ovaltine::Decoder do
  it "should have all 25 rot decoders" do
    expect(Ovaltine::Decoder.constants.collect { |c|
      Ovaltine::Decoder.const_get(c)
    }.select { |c|
      c.is_a? Module and c.methods(false).include? :decode
    }.select { |c|
      c.name.split("::")[-1].start_with? "Rot"
    }.length).to eq(25)
  end
end

describe Ovaltine::Decoder::Rot13 do
  it "should decode rot13" do
    expect(Ovaltine::Decoder::Rot13.decode("Gb trg gb gur bgure fvqr!"))
          .to eq("To get to the other side!")
  end
end

describe Ovaltine::Decoder::Rot5 do
  it "should decode rot5" do
    expect(Ovaltine::Decoder::Rot5.decode("Oj bzo oj ocz joczm ndyz!"))
          .to eq("To get to the other side!")
  end
end
