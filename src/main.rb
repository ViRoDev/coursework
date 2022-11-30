def to_ternary(x); end

# Tests
require 'test/unit'
class TestCantor < Test::Unit::TestCase
  def test_to_ternary
    assert_equal(10, to_ternary(3))
  end
end
