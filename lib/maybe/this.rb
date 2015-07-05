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

    private
    attr_accessor :value
  end
end
