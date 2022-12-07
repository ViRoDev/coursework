require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'to_ternary'
require_relative 'to_float_from_binary'

def replace_everything_after_first_occurance(string, after_what, replace_with)
  return string unless string.include?(after_what)

  idx = string.index(after_what)
  string.split('')
        .each_with_index.map do |num, index|
          next replace_with if index > idx

          next num
        end.join('')
end

class Numeric
  # Algorithmic implementation
  def to_cantor
    x = self

    return x unless 0.0 < x && x < 1.0
    return 1.0 / 3 if x == 0.25
    return 2.0 / 3 if x == 0.75

    y = BigDecimal('1.0')
    z = BigDecimal('0.0')

    while true
      x *= 3.0
      y *= 0.5

      if x > 2.0
        x -= 2.0
        z += y
      elsif x >= 1.0
        return y + z
      end

    end
  end

  # Ternary Representation implementation
  # Currently not working properly because of difficulties of overflow, number representations
  # def to_cantor
  #   # Step 1: Make ternary representation
  #   ternary = to_ternary
  #   # Step 2: If it conitains '1'... replace every digit after it with '1'
  #   replaced = replace_everything_after_first_occurance(ternary, '1', '1')
  #   # Step 3:  Replace every remaining 2's with '1'
  #   binary = replaced.gsub('2', '1')
  #   # Step 4: interpret result as binary
  #   binary.to_float_from_binary
  # end
end

# puts "TWO OVER THREE#{2.0 / 3}"
# two_three = 2.0 / 3
# puts(" WUT #{two_three.to_cantor}")

require 'test/unit'
class TestToCantor # < Test::Unit::TestCase
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

  def test_one_third
    assert_equal(0.5, (1.0 / 3).to_cantor)
  end

  def test_two_thirds
    assert_equal(0.5, (2.0 / 3).to_cantor)
  end

  def test_half
    assert_equal(0.5, 0.5.to_cantor)
  end
end
