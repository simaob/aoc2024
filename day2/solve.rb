#!/usr/bin/env ruby

def check_safe(report)
  # Reports are deemed safe if:
  # The levels are either all increasing or all decreasing.
  # Any two adjacent levels differ by at least one and at most three.

  levels = report.split(" ")

  current_direction = nil # 1 up, 2 down
  (0..levels.size).each do |index|
    return true if index == levels.size - 1

    diff = levels[index+1].to_i - levels[index].to_i
    return false if diff.abs < 1 || diff.abs > 3

    return false if current_direction && (current_direction * diff).negative?


    current_direction = diff
  end
end

safe_reports = 0

File.open("input.txt", "r").each do |report|
  safe_reports += 1 if check_safe(report)
end

puts "There are #{safe_reports} safe reports"
