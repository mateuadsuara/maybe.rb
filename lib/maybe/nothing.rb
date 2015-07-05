module Maybe
  class Nothing
    def self.do(&side_effect)
      self
    end

    def self.or(&alternative)
      yield
    end

    def self.change(&transformation)
      self
    end
  end
end
