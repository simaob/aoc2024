#!/usr/bin/env ruby

require "byebug"

# X-MAS
# ..M.S..
# ...A...
# ..M.S..

def has_x_mas?(y, x, matrix, matches)
  return false if matrix.first.size <= x || matrix.size <= y

  top_left = matrix[y - 1][x - 1]
  top_right = matrix[y - 1][x + 1]
  bottom_left = matrix[y + 1][x - 1]
  bottom_right = matrix[y + 1][x + 1]

  if [top_left, top_right, bottom_left, bottom_right].sort != ["M", "M", "S", "S"]
    return false
  end

  if top_left != bottom_right && bottom_left != top_right
    matches[y - 1][x - 1] = matrix[y - 1][x - 1]
    matches[y - 1][x + 1] = matrix[y - 1][x + 1]
    matches[y][x] = "A"
    matches[y + 1][x - 1] = matrix[y + 1][x - 1]
    matches[y + 1][x + 1] = matrix[y + 1][x + 1]
    return true
  end

  false
end

input = File.read("sample_input.txt").split

matches = input.map { |sub_array| Array.new(sub_array.size, ".") }

count_xmas = 0

## Find XMAS
input.each_with_index do |line, i|
  next if i.zero? || i == input.size - 1

  line.each_char.with_index do |char, j|
    next if j.zero? || j == line.size - 1

    if char == "A" && has_x_mas?(i, j, input, matches)
      count_xmas += 1
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
