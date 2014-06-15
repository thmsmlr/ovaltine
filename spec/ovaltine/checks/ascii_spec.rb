require "ovaltine/checks/ascii"

describe Ovaltine::Check::AsciiCheck do
  it "should fail on unicode" do
    expect(Ovaltine::Check::AsciiCheck.check("\xC3"))
          .to eq(false)
  end

  it "should pass on ascii" do
    expect(Ovaltine::Check::AsciiCheck.check("Hello"))
          .to eq(true)
  end
end

