#!/usr/bin/env ruby

# Reports are deemed safe if:
# The levels are either all increasing or all decreasing.
# Any two adjacent levels differ by at least one and at most three.


def safe_pair?(item, next_item, current_direction)
  diff = next_item.to_i - item.to_i
  return false if diff.abs < 1 || diff.abs > 3

  return false if current_direction && (current_direction * diff).negative?

  diff
end

def check_safe(levels)
  current_direction = nil
  (0..levels.size).each do |index|
    return true if index == levels.size - 1

    current_direction = safe_pair?(levels[index], levels[index + 1], current_direction)

    return false unless current_direction
  end
end

def check_safe_with_tolerance(levels)
  return true if check_safe(levels)

  (0...levels.size).each do |index|
    trimmed = levels[0...index] + levels[index+1..-1]
    return true if check_safe(trimmed)
  end

  false
end

safe_reports = 0
safe_reports_with_tolerance = 0

File.open("input.txt", "r").each do |report|
  levels = report.split(" ")

  safe_reports += 1 if check_safe(levels)
  safe_reports_with_tolerance += 1 if check_safe_with_tolerance(levels)
end

puts "There are #{safe_reports} safe reports"
puts "There are #{safe_reports_with_tolerance} safe reports when giving tolerance"
