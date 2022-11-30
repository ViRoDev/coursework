def to_ternary(x)
  res = ''
  while x >= 3
    res << (x % 3).to_s
    x /= 3
  end

  res << x.to_s
  res.reverse
end

# Tests
require 'test/unit'
class TestCantor < Test::Unit::TestCase
  def test_base_ternary
    assert_equal(10.to_s, to_ternary(3))
    print 'Base Test Passed'
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
end
