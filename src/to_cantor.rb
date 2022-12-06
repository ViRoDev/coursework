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

class String
  def fractional_part?
    !to_f.modulo(1).eql?(0.0)
  end

  def integer_part_binary
    to_f.floor.to_i.to_s(2).to_i
  end

  def fractional_part_binary
    to_f.modulo(1).to_s.split('.')[1]
  end

  # With precision up to 3 digits after the dot
  def to_float_from_binary
    base = 2
    return to_i(2).to_f unless fractional_part?

    # If not, convert the hard way...
    integer_part = integer_part_binary
    fractional_part = fractional_part_binary

    one_over_base = 1.0 / base

    values = fractional_part.split('').each_with_index.map do |digit, idx|
      next digit.to_i * (one_over_base**(idx + 1))
    end

    fractional_part = values.reduce(0.0) do |sum, num|
      sum + num
    end

    integer_part + fractional_part.to_s[0..4].to_f
  end
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
