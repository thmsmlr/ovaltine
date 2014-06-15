
require "ovaltine/check"

module Ovaltine::Check::IdentityCheck
  def self.check(str)
    return True
  end
end

module Ovaltine::Check::FauxCheck
  def self.check(str)
    return True
  end
end

module Ovaltine
  describe Check do
    context "#all_checks" do
      it "should return all loaded check functions" do
        checks = Ovaltine::Check.all_checks
        expect(checks.length).to be >= 1
        expect(checks).to include(Ovaltine::Check::IdentityCheck)
        expect(checks).to include(Ovaltine::Check::FauxCheck)
      end

      it "should not return black-listed checks" do
        checks = Ovaltine::Check.all_checks(
          :black_list => [Ovaltine::Check::IdentityCheck]
        )

        expect(checks.length).to be >= 1
        expect(checks).to_not include(Ovaltine::Check::IdentityCheck)
        expect(checks).to include(Ovaltine::Check::FauxCheck)
      end
    end
  end
end

