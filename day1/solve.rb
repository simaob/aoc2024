#!/usr/bin/env ruby

col1 = []
col2 = []

# filename = "sample_input.txt"
filename = "input.txt"

File.open(filename, "r").each do |line|
  first, second = line.split(" ")
  col1 << first.to_i
  col2 << second.to_i
end

if col1.size != col2.size
  puts "Columns are not the same size..."
  return
end

col1.sort!
col2.sort!

distances = 0
similarity = 0

(0...col1.size).each do |i|
  distances += (col1[i] - col2[i]).abs
  similarity += col1[i] * col2.select { |el| el == col1[i] }.size
end

puts "Total distance is: #{distances}"
puts "Total similarity is: #{similarity}"
