positions = gets.split(",").map(&:to_i).sort

puts (positions.min..positions.max).map { |i|
  positions.reduce(0) { |sum,x| sum + (x-i).abs }
}.min
