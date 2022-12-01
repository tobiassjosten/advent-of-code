positions = gets.split(",").map(&:to_i).sort

puts (positions.min..positions.max).map { |i|
  positions.reduce(0) { |sum,x|
    distance = (x-i).abs
    sum + distance * (distance + 1) / 2
  }
}.min
