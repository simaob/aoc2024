#!/usr/bin/env ruby

require "byebug"

MOVES = {
  "^": [-1, 0],
  "v": [1, 0],
  ">": [0, 1],
  "<": [0, -1],
}.freeze

CHANGE_DIR = {
  "^": ">",
  ">": "v",
  "v": "<",
  "<": "^",
}.freeze

FREE_SPACE = ".".freeze

BLOCKER = "#".freeze

VISITED = "X".freeze

def out_of_bounds?(next_pos, height, width)
  next_pos[0].negative? || next_pos[1].negative? ||
    next_pos[0] >= height || next_pos[1] >= width
end

map = File.read("input.txt").split

height = map.size
width = map.first.size

current_pos = []
current_dir = ""

# Find start position
map.each_with_index do |line, yy|
  line.each_char.with_index do |pos, xx|
    if ["^", "v", ">", "<"].include?(pos)
      current_pos = [yy, xx]
      current_dir = pos
    end
  end
end

loop do
  move = MOVES[current_dir.to_sym]
  next_pos = [current_pos[0] + move[0], current_pos[1] + move[1]]

  if out_of_bounds?(next_pos, height, width)
    map[current_pos[0]][current_pos[1]] = VISITED
    break
  end

  if map[next_pos[0]][next_pos[1]] != BLOCKER
    map[current_pos[0]][current_pos[1]] = VISITED
    current_pos = next_pos
    map[current_pos[0]][current_pos[1]] = current_dir
  else
    current_dir = CHANGE_DIR[current_dir.to_sym]
  end
end

count_x = 0
map.each_with_index do |line, yy|
  line.each_char.with_index do |pos, xx|
    count_x += 1 if pos == VISITED
    print pos
  end
  print "\n"
end

print "The guard visited #{count_x} positions"
