def integer_to_ternary(x)
  x
    .floor
    .to_i
    .to_s(3)
end

# Tests
require 'test/unit'
class TestIntegerTernary < Test::Unit::TestCase
  def test_base_ternary
    assert_equal(10.to_s, integer_to_ternary(3))
  end

  def test_zero_ternary
    assert_equal(0.to_s, integer_to_ternary(0))
  end

  def test_one_digit_ternary
    assert_equal(2.to_s, integer_to_ternary(2))
  end

  def test_two_digits_ternary
    assert_equal(12.to_s, integer_to_ternary(5))
  end

  def test_three_digits_ternary
    assert_equal(1000.to_s, integer_to_ternary(27))
  end

  def test_three_digits_ternary_2
    assert_equal(1122.to_s, integer_to_ternary(44))
  end
end
