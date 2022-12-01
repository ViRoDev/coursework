### RETURNS ONLY FRACTIONAL PARM, WITHOUT 0. IN FRONT OF IT
### Has hardcoded limit to 10 digits

CALCULATION_LIMIT = 15
PRECISION = 10
BASE = 3
def fractional_to_ternary(number)
  res = ''
  limit = CALCULATION_LIMIT # additional to check overflow
  while number.modulo(1) != 0 && limit > 0
    number *= BASE
    integer_part = number.floor
    fractional_part = number.modulo(1)

    res << integer_part.to_s
    number = fractional_part
    limit -= 1
  end
  res << number.to_i.to_s

  res = remove_trailing_zeroes(res)

  # for bases < 10, for bases > 10, this code should be replaced
  if res[-1] == (BASE - 1).to_s
    reversed = res.reverse # res[0..CALCULATION_LIMIT].reverse
    ovrfl = true
    overflowed = ''
    for char in reversed.split('')
      if ovrfl
        case char
          # TODO: rewrite to any base
        when '0'
          overflowed << '1'
          ovrfl = false
        when '1'
          overflowed << '2'
          ovrfl = false
        when '2'
          overflowed << '0'
          overf = true
        end
      else
        overflowed << char
      end
    end
    res = overflowed.reverse
  end
  # Hardcoded, yeah
  remove_trailing_zeroes(res)[0..PRECISION - 1]
end

def remove_trailing_zeroes(string_number)
  "0.#{string_number}"
    .to_f # removes trailing zeroes
    .to_s
    .split('.')[1] # gets fractional part
end

# Tests
require 'test/unit'
class TestFractionalTernary < Test::Unit::TestCase
  def test_one_over_base
    assert_equal('1', fractional_to_ternary(1.0 / 3))
  end

  def test_zero_ternary
    assert_equal(0.to_s, fractional_to_ternary(0.0))
  end

  def test_smaller_fractions
    assert_equal('01', fractional_to_ternary(1.0 / 9))
  end

  def test_0_24
    assert_equal('0201102212', fractional_to_ternary(0.24))
  end
end
