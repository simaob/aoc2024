#!/usr/bin/env ruby

require "byebug"


def good_update?(update, rules)
  update.each_with_index do |page, idx|
    remaining = update[idx + 1..]
    if rules.any? { |pre, fol| page == fol && remaining.include?(pre) }
      return false
    end

    previous = update[0..idx]
    if rules.any? { |pre, fol| previous.include?(fol) && pre == page }
      return false
    end
  end
  true
end

filename = "input.txt"

importing_rules = true
rules = []
updates_to_fix = []
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
    if good_update?(update, rules)
      sum_middle_pages += update[update.size / 2].to_i
    else
      updates_to_fix << update
    end
  end
end

puts "The total sum for correct updates' middle pages is #{sum_middle_pages}"

sum_middle_pages = 0
## Now let's fix the ones that were wrong
updates_to_fix.each do |update|
  loop do
    # No energy to solve this properly, so I'll just take the lazy route...
    # fix one broken rule at a time and check if I'm done before fixing the next broken rule
    # bit of a slow process... but seems to work =D
    update.each_with_index do |page, idx|
      remaining = update[idx + 1..]
      to_swap = rules.select { |pre, fol| page == fol && remaining.include?(pre) }

      unless to_swap.empty?
        a = to_swap.first[0]
        b = to_swap.first[1]
        a_idx = update.index(a)
        b_idx = update.index(b)
        update[a_idx] = b
        update[b_idx] = a
        break
      end

      previous = update[0..idx]
      to_swap_maybe = rules.select { |pre, fol| previous.include?(fol) && pre == page }

      unless to_swap_maybe.empty?
        a = to_swap_maybe.first[0]
        b = to_swap_maybe.first[1]
        a_idx = update.index(a)
        b_idx = update.index(b)
        update[a_idx] = b
        update[b_idx] = a
        break
      end
    end

    break if good_update?(update, rules)
  end
  sum_middle_pages += update[update.size / 2].to_i
end

puts "The total sum for fixed updates' middle pages is #{sum_middle_pages}"
