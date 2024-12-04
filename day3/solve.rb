#!/usr/bin/env ruby

# find mul(#,#) where # has 1 to 3 digits. Multiply and sum them.
def find_muls_and_run_them(instruction)
  result = 0
  instruction.scan(/mul\(([1-9][0-9]?[0-9]?),([1-9][0-9]?[0-9]?)\)/m) do |a, b|
    result += a.to_i * b.to_i
  end
  result
end

# PART ONE solution
result = find_muls_and_run_them(File.read("input.txt"))

puts "PART ONE: There result of the instruction is: #{result}"

# PART TWO solution
# instructions start enabled
# dont() disable them
# do() re-enable them
#
# read the whole file as the simple input as instructions don't care about new lines
instruction = File.read("input.txt")

# first we remove everything that is after a don't() and before a do()
# the /m ensures that newlines are consumed and don't break our analysis
instruction.gsub!(/don't\(\)(.*?)do\(\)/m, "")

result = find_muls_and_run_them(instruction)

puts "There result of the instruction is: #{result}"
