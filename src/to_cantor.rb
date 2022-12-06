require_relative 'to_ternary'
require_relative 'to_float_from_binary'

def replace_everything_after_first_occurance(string, after_what, replace_with)
  ternary = string
  return string unless ternary.include?(after_what)

  # ..Replace every single digit after it w/ '1'
  idx = ternary.index(after_what)
  ternary.split('').each_with_index.map do |num, index|
    next replace_with if index > idx

    next num
  end.join('')
end

class Numeric
  def to_cantor
    # Step 1: Make ternary representation
    ternary = to_ternary

    # Step 2: If it conitains '1'...
    replaced = replace_everything_after_first_occurance(ternary, '1', '1')
    # Step 3:  Replace every remaining 2's with '1'
    binary = replaced.gsub('2', '1')

    # Step 4: interpret result as binary
    binary.to_float_from_binary
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

  # 1 / 4 in base10 => 0.02020202 in base3
  # replace every digit after first 1 with 1
  # (no 1's, so skip)
  # replace every 2 with 1
  # => 0.0101010101...
  # 0.01010101 in base2 == 1/3 in base10
  def test_fraction_one_over_four
    assert_equal((1.0 / 3).to_s[0..4].to_f, (1.0 / 4).to_cantor)
  end
end
