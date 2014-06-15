require "ovaltine/checks/dictionary"

describe Ovaltine::Check::DictionaryCheck do
  before(:each) do
    @old_dict = Ovaltine::Check::DictionaryCheck.class_variable_get(:@@dictionary)
    Ovaltine::Check::DictionaryCheck.class_variable_set(:@@dictionary, [
      "apple",
      "banana"
    ].to_set)
  end

  after(:each) do
    Ovaltine::Check::DictionaryCheck.class_variable_set(:@@dictionary, @old_dict)
  end

  it "should fail on japanese word" do
    expect(Ovaltine::Check::DictionaryCheck.check("Konnichiwa"))
          .to eq(false)
  end

  it "should pass on english word" do
    expect(Ovaltine::Check::DictionaryCheck.check("apple"))
          .to eq(true)
  end

  it "should pass on capitalized word" do
    expect(Ovaltine::Check::DictionaryCheck.check("ApPle"))
          .to eq(true)
  end

  it "should fail if less than 15% of the words are english" do
    expect(Ovaltine::Check::DictionaryCheck.check("apple z z z z z z"))
          .to eq(false)
  end
end
