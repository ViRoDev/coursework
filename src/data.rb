require_relative 'to_cantor'

NUMBER_OF_DOTS = 1000
def get_data
  dots = 1..NUMBER_OF_DOTS

  arr = []
  dots.each do |value|
    arr.push(1.0 * value / NUMBER_OF_DOTS)
  end

  # print arr
  arr.map do |el|
    # puts "\nNumber: #{el} -> Ternary: #{el.to_ternary} -> Cantor: #{el.to_cantor}"
    [el.to_s, el.to_cantor]
  end
end

get_data
