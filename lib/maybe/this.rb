module Maybe
  class This
    def initialize(value)
      @value = value
    end

    def do(&side_effect)
      yield value
      self
    end

    def or(&alternative)
      value
    end

    def change(&transformation)
      self.class.new(yield value)
    end

    def if(&predicate)
      return self if yield value
      Maybe::Nothing
    end

    private
    attr_reader :value
  end
end
