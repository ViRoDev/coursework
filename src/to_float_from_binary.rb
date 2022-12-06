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

    # For some reason, de-magical-ination of that precision number
    # destroys precision of the program
    # I love dynamicly typed languages!
    integer_part + fractional_part.to_s[0..4].to_f
  end
end
