#!/usr/bin/env ruby

require "byebug"

def count_extra_xmas(starting_char, y, x, matrix)
  xmas = ["X", "M", "A", "S"]
  xmas = xmas.reverse unless starting_char == "X"

  enough_width = matrix.first.size > x + 3
  enough_height = matrix.size > y + 3

  count_xmas = 0

  # Horizontal
  # .XMAS...
  #
  # or
  #
  # .SAMX...

  if enough_width && xmas.select.with_index { |l, i| l == matrix[y][x + i] }.size == 4
    xmas.each_with_index do |l, idx|
      @matches[y][x + idx] = l
    end
    count_xmas += 1
  end

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
  # rightwards
  if enough_width && enough_height &&
      xmas.select.with_index { |l, i| l == matrix[y + i][x + i] }.size == 4
    xmas.each_with_index do |l, idx|
      @matches[y + idx][x + idx] = l
    end
    count_xmas += 1
  end
  if enough_height
    if x - 3 >= 0 && xmas.select.with_index { |l, i| l == matrix[y + i][x - i] }.size == 4 # leftwards
      xmas.each_with_index do |l, idx|
        @matches[y + idx][x - idx] = l
      end
      count_xmas += 1
    end

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
    if xmas.select.with_index { |l, i| l == matrix[y + i][x] }.size == 4
      xmas.each_with_index do |l, idx|
        @matches[y + idx][x] = l
      end
      count_xmas += 1
    end
  end
  count_xmas
end

input = File.read("input.txt").split

@matches = input.map { |sub_array| Array.new(sub_array.size, ".") }

count_xmas = 0

input.each_with_index do |line, i|
  line.each_char.with_index do |char, j|
    if ["X", "S"].include?(char)
      count_xmas += count_extra_xmas(char, i, j, input)
    end
  end
end

puts "Search found #{count_xmas} matches"

@matches.each do |row|
  row.each do |letter|
    print letter
  end
  print "\n"
end
