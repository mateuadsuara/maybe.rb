require 'maybe'

RSpec.describe Maybe do
  describe 'do method for' do
    describe Maybe::This do
      it 'will execute side effects with its value' do
        this_value = Maybe::This.new("value")

        side_effect = "nothing happened"
        this_value.do {|it| side_effect = "done with: #{it}"}

        expect(side_effect).to eq("done with: value")
      end

      it 'will return itself' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.do {}
        expect(returned_value).to be(this_value)
      end
    end

    describe Maybe::Nothing do
      it 'will not execute side effects' do
        nothing = Maybe::Nothing

        side_effect = "nothing happened"
        nothing.do {|it| side_effect = "done with: #{it}"}

        expect(side_effect).to eq("nothing happened")
      end

      it 'will return itself' do
        nothing = Maybe::Nothing
        returned_value = nothing.do {}
        expect(returned_value).to be(nothing)
      end
    end
  end

  describe 'or method for' do
    describe Maybe::This do
      it 'will return its value' do
        this_value = Maybe::This.new("value")
        returned_value = this_value.or {"alternative value"}
        expect(returned_value).to eq("value")
      end
    end

    describe Maybe::Nothing do
      it 'will return the alternative value' do
        nothing = Maybe::Nothing
        returned_value = nothing.or {"alternative value"}
        expect(returned_value).to eq("alternative value")
      end
    end
  end
end
