require_relative 'to_ternary'

def replace_every_digit_after_first_1(string)
  ternary = string
  return string unless ternary.include?('1')

  # ..Replace every single digit after it w/ '1'
  idx = ternary.index('1')
  ternary.split('').each_with_index.map do |num, index|
    next '1' if index > idx

    next num
  end.join('')
end

class Numeric
  def to_cantor
    # Step 1: Make ternary representation
    ternary = to_ternary

    # Step 2: If it conitains '1'...
    replaced = replace_every_digit_after_first_1(ternary)
    # Step 3:  Replace every remaining 2's with '1'
    binary = replaced.gsub('2', '1')

    # Step 4: interpret result as binary
    # TODO: implement conversion
    #
    # binary.to_f

    # Works for integer values, but we need it for fractional too
    print "\n\nBINARY: #{binary}\n\n"
    return binary.to_i(2) if to_f.modulo(1).eql?(0.0)

    binary.to_f
  end
end

require 'test/unit'
class TestToCantor < Test::Unit::TestCase
  def test_to_cantor_zero
    assert_equal(0, 0.to_cantor)
  end

  # 3 in base10 => 10 in base3
  # replace every digit after first 1 with 1
  # => 11
  # replace every 2 with 1
  # => (no 2's, so skip)
  # => interpret as binary
  # 11 in base2 is 3 in base10
  def test_to_cantor_three
    assert_equal(3, 3.to_cantor)
  end

  # 5 in base10 => 12 in base3
  # replace every digit after first 1 with 1
  # => 11
  # replace every 2 with 1
  # => (no 2's, so skip)
  # => interpret as binary
  # 11 in base2 is 3 in base10
  def test_to_cantor_five
    assert_equal(3, 5.to_cantor)
  end

  # 6 in base10 => 20 in base3
  # replace every digit after first 1 with 1
  # => (no 1's, so skip)
  # replace every 2 with 1
  # => 10
  # => interpret as binary
  # 10 in base2 is 2 in base10
  def test_to_cantor_six
    assert_equal(2, 6.to_cantor)
  end
end
