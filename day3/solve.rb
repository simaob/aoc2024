#!/usr/bin/env ruby

require "byebug"

result = 0
File.open("input.txt", "r").each do |instruction|
  instruction.scan(/mul\(([1-9][0-9]?[0-9]?),([1-9][0-9]?[0-9]?)\)/) do |a, b|
    result += a.to_i * b.to_i
  end
end

puts "There result of the instruction is: #{result}"
