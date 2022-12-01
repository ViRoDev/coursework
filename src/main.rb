require_relative 'integer_to_ternary'
require_relative 'fractional_to_ternary'

def to_ternary(number)
  res = ''
  integer_base10 = number.floor

  integer_base3 = integer_to_ternary(integer_base10)
  fractional_base3 = fractional_to_ternary(number.modulo(1))
  #   print fractional_base3
  res << integer_base3.to_s

  #   print 12.0.modulo(1).eql?(0.0)
  return res.to_i.to_s if number.to_f.modulo(1).eql?(0.0)

  res << '.' << fractional_base3
  res
end

# Tests
require 'test/unit'
require 'bigdecimal'
require 'bigdecimal/util'
class TestTernary < Test::Unit::TestCase
  def test_base_ternary
    assert_equal(10.to_s, to_ternary(3))
  end

  def test_zero_ternary
    assert_equal(0.to_s, to_ternary(0))
  end

  def test_one_digit_ternary
    assert_equal(2.to_s, to_ternary(2))
  end

  def test_two_digits_ternary
    assert_equal(12.to_s, to_ternary(5))
  end

  def test_three_digits_ternary
    assert_equal(1000.to_s, to_ternary(27))
  end

  def test_three_digits_ternary_2
    assert_equal(1122.to_s, to_ternary(44))
  end

  def test_with_fractions_zero
    assert_equal('0', to_ternary(0.0))
  end

  def test_with_fractions_one_and_one_over_base
    assert_equal('1.1', to_ternary(1 + 1.0 / 3))
  end
end
