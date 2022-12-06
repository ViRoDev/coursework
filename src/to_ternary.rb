require_relative 'integer_to_ternary'
require_relative 'fractional_to_ternary'

class Numeric
  def to_ternary
    number = self
    res = ''
    integer_base10 = number.floor

    integer_base3 = integer_to_ternary(integer_base10)
    fractional_base3 = fractional_to_ternary(number.modulo(1))
    res << integer_base3.to_s
    return res.to_i.to_s if number.to_f.modulo(1).eql?(0.0)

    res << '.' << fractional_base3
  end
end

# Tests
require 'test/unit'
require 'bigdecimal'
require 'bigdecimal/util'
class TestTernary < Test::Unit::TestCase
  def test_base_ternary
    assert_equal(10.to_s, 3.to_ternary)
  end

  def test_zero_ternary
    assert_equal(0.to_s, 0.to_ternary)
  end

  def test_one_digit_ternary
    assert_equal(2.to_s, 2.to_ternary)
  end

  def test_two_digits_ternary
    assert_equal(12.to_s, 5.to_ternary)
  end

  def test_three_digits_ternary
    assert_equal(1000.to_s, 27.to_ternary)
  end

  def test_three_digits_ternary_2
    assert_equal(1122.to_s, 44.to_ternary)
  end

  def test_with_fractions_zero
    assert_equal('0', 0.0.to_ternary)
  end

  def test_with_fractions_one_and_one_over_base
    assert_equal('1.1', (1 + 1.0 / 3).to_ternary)
  end
end
