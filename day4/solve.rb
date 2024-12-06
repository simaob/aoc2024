#!/usr/bin/env ruby

require "./helpers"
require "byebug"

# Horizontal
# .XMAS...
#
# or
#
# .SAMX...
#
# Diagonal XMAS could be:
# .X.....
# ..M....
# ...A...
# ....S..
#
# or
#
# ...X.
# ..M..
# .A...
# S....
#
# or
#
# .S...
# ..A..
# ...M.
# ....X
#
# or
#
# ....S.
# ...A..
# ..M...
# .X....
#
# Vertical:
#
# ..X..
# ..M..
# ..A..
# ..S..
#
# or
#
# ..S..
# ..A..
# ..M..
# ..X..

def count_xmas(starting_char, y, x, matrix, matches)
  xmas = ["X", "M", "A", "S"]
  xmas = xmas.reverse unless starting_char == "X"

  enough_width = matrix.first.size > x + 3
  enough_height = matrix.size > y + 3

  count_xmas = 0

  horizontal_coords = (0...xmas.size).map { |i| [y, x + i] }
  diagonal_right_coords = (0...xmas.size).map { |i| [y + i, x + i] }
  diagonal_left_coords = (0...xmas.size).map { |i| [y + i, x - i] }
  vertical_coords = (0...xmas.size).map { |i| [y + i, x] }

  if enough_width && matches_word?(xmas, horizontal_coords, matrix)
    set_matches(xmas, horizontal_coords, matches)
    count_xmas += 1
  end

  if enough_width && enough_height && matches_word?(xmas, diagonal_right_coords, matrix)
    set_matches(xmas, diagonal_right_coords, matches)
    count_xmas += 1
  end

  if enough_height && x - 3 >= 0 && matches_word?(xmas, diagonal_left_coords, matrix)
    set_matches(xmas, diagonal_left_coords, matches)
    count_xmas += 1
  end

  if enough_height && matches_word?(xmas, vertical_coords, matrix)
    set_matches(xmas, vertical_coords, matches)
    count_xmas += 1
  end

  count_xmas
end

input = File.read("input.txt").split

matches = input.map { |sub_array| Array.new(sub_array.size, ".") }

count_xmas = 0

## Find XMAS
input.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    if ["X", "S"].include?(char)
      count_xmas += count_xmas(char, i, j, input, matches)
    end
  end
end

matches.each do |row|
  row.each do |letter|
    print letter
  end
  print "\n"
end

puts "Search found #{count_xmas} matches"
