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

  handle_overflow(remove_trailing_zeroes(res))
end

# for bases < 10, for bases > 10, this code should be replaced
# TODO: add test coverage
def handle_overflow(potential_overflowed_ternary)
  res = potential_overflowed_ternary
  if res[-1] == (BASE - 1).to_s
    reversed = res.reverse # res[0..CALCULATION_LIMIT].reverse
    is_prev_overflowed = true
    overflowed = ''
    for char in reversed.split('')
      if is_prev_overflowed
        case char
          # TODO: rewrite to any base
          # Maybe create a dictionary for every digit of new base :?
        when '0'
          overflowed << '1'
          is_prev_overflowed = false
        when '1'
          overflowed << '2'
          is_prev_overflowed = false
        when '2'
          overflowed << '0'
          is_prev_overflowed = true
        end
      else
        overflowed << char
      end
    end
    res = overflowed.reverse
  end
  # Hardcoded, yeah
  # What are you gonna do 'bout it?
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

  def test_fraction_one_over_two
    assert_equal('1111111111', fractional_to_ternary(1.0 / 2))
  end

  def test_fraction_one_over_four
    assert_equal('0202020202', fractional_to_ternary(1.0 / 4))
  end

  def test_fraction_one_over_five
    assert_equal('0121012101', fractional_to_ternary(1.0 / 5))
  end

  def test_fraction_one_over_six
    assert_equal('0111111111', fractional_to_ternary(1.0 / 6))
  end
end
