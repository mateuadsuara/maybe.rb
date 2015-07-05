module Maybe
  class This
    def initialize(value)
      @value = value
    end

    def do(&invoke_side_effect)
      yield value
      self
    end

    def or(&alternative)
      value
    end

    private
    attr_accessor :value
  end
end
