require 'maybe'

RSpec.describe Maybe do
  describe 'do method for' do
    describe Maybe::This do
      it 'executes side effects with its value' do
        this_value = Maybe::This.new("value")

        side_effect = "nothing happened"
        this_value.do {|it| side_effect = "done with: #{it}"}

        expect(side_effect).to eq("done with: value")
      end

      it 'returns itself' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.do {}
        expect(returned_value).to be(this_value)
      end
    end

    describe Maybe::Nothing do
      it 'does not execute side effects' do
        nothing = Maybe::Nothing

        side_effect = "nothing happened"
        nothing.do {|it| side_effect = "done with: #{it}"}

        expect(side_effect).to eq("nothing happened")
      end

      it 'returns itself' do
        nothing = Maybe::Nothing
        returned_value = nothing.do {}
        expect(returned_value).to be(nothing)
      end
    end
  end

  describe 'or method for' do
    describe Maybe::This do
      it 'returns its value' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.or {"alternative value"}
        expect(returned_value).to eq("value")
      end
    end

    describe Maybe::Nothing do
      it 'returns the alternative value' do
        nothing = Maybe::Nothing
        returned_value = nothing.or {"alternative value"}
        expect(returned_value).to eq("alternative value")
      end
    end
  end

  describe 'change method for' do
    describe Maybe::This do
      it 'transforms its value into a new one' do
        original_value = Maybe::This.new("value")
        changed_value = original_value.change {|it| it.upcase}
        expect(changed_value.or{}).to eq("VALUE")
        expect(original_value.or{}).to eq("value")
      end
    end

    describe Maybe::Nothing do
      it 'returns itself' do
        nothing = Maybe::Nothing
        changed_nothing = nothing.change {|it| it.upcase}
        expect(changed_nothing).to be(nothing)
      end
    end
  end

  describe 'if method for' do
    describe Maybe::This do
      it 'returns itself when the predicate is true' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.if {|it| it == "value"}
        expect(returned_value).to be(this_value)
      end

      it 'returns nothing when the predicate is false' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.if {|it| it != "value"}
        expect(returned_value).to be(Maybe::Nothing)
      end
    end

    describe Maybe::Nothing do
      it 'returns itself' do
        nothing = Maybe::Nothing
        returned_value = nothing.if {|it| it == "value"}
        expect(returned_value).to be(nothing)
      end
    end
  end
end
