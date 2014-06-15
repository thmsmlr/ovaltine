require "ovaltine/decoders/base64"

describe Ovaltine::Decoder::Base64 do
  it "should decode base64" do
    expect(Ovaltine::Decoder::Base64.decode("VG8gZ2V0IHRvIHRoZSBvdGhlciBzaWRlIQ=="))
          .to eq("To get to the other side!")
  end
end
