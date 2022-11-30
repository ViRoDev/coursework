def to_ternary(x)
  res = ''

  if x % 3 == 0 && x != 0
    x %= 3
    res << '1'
    while x % 3 != 0
      print x
      res << '1'
      x %= 3
    end
  end
  res << x.to_s
end

# Tests
require 'test/unit'
class TestCantor < Test::Unit::TestCase
  def test_base_ternary
    assert_equal(10.to_s, to_ternary(3))
  end

  def test_zero_ternary
    assert_equal(0.to_s, to_ternary(0))
  end
end
