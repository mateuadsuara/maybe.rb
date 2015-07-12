module Maybe
  def self.this(value)
    return nothing if value.nil?
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
      self.class.new(yield value)
    end

    def if(&predicate)
      return self if yield value
      Maybe.nothing
    end

    private
    attr_reader :value
  end
end
