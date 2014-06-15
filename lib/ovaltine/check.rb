
module Ovaltine
  module Check
    def self.all_checks(opts={})
      opts[:black_list] ||= []
      self.constants.collect { |c|
        self.const_get(c)
      }.select { |c|
        c.is_a?(Module) && ! opts[:black_list].include?(c)
      }
    end
  end
end
