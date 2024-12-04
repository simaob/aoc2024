#!/usr/bin/env ruby

col1 = []
col2 = []

File.open("../input.txt", "r").each do |line|
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

differences = 0

(0...col1.size).each do |i|
  differences += (col1[i] - col2[i]).abs
end

puts "Total difference is: #{differences}"
