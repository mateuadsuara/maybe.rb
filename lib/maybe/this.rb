module Maybe
  def self.this(value)
    return Nothing if value.nil?
    return value if value == Nothing || value.instance_of?(This)
    This.new(value)
  end

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
      Maybe.this(yield value)
    end

    def if(&predicate)
      return self if yield value
      Maybe.nothing
    end

    private
    attr_reader :value
  end
end
