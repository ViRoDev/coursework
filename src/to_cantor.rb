require_relative 'to_ternary'

class Numeric
  def to_cantor
    # Step 1: Make ternary representation
    ternary = to_ternary

    # Step 2: If it conitains '1'...
    if ternary.include?('1')
      # ..Replace every single digit after it w/ '1'
      idx = ternary.index('1')
      ternary = ternary.split('').each_with_index.map do |num, index|
        next '1' if index > idx

        next num
      end.join('')

      ternary
    end

    # Step 3:  Replace every remaining 2's with '1'
    ternary.split.map do |num|
      next '1' if num == '2'

      next num
    end.join('')

    # Step 4: interpret result as binary
    # TODO: implement conversion
    #
    # binary.to_f
  end
end

require 'test/unit'
class TestToCantor < Test::Unit::TestCase
  def test_to_cantor_zero
    assert_equal('0', 0.to_cantor)
  end
end
