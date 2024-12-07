#!/usr/bin/env ruby

require "byebug"

filename = "input.txt"

importing_rules = true
rules = []
sum_middle_pages = 0

File.open(filename, "r").each do |line|
  if line == "\n"
    importing_rules = false
    next
  end

  if importing_rules
    first, second = line.split("|")
    rules << [first.to_i, second.to_i]
  else
    update = line.split(",").map(&:to_i)
    good_update = true
    update.each_with_index do |page, idx|
      remaining = update[idx + 1..]
      if rules.any? { |pre, fol| page == fol && remaining.include?(pre) }
        good_update = false
      end
      previous = update[0..idx]
      if rules.any? { |pre, fol| previous.include?(fol) && pre == fol }
        good_update = false
      end
    end
    if good_update
      puts "#{line} is a good update!"
      sum_middle_pages += update[update.size / 2].to_i
    end
  end
end

puts "The total sum for legal updates' middle pages is #{sum_middle_pages}"
