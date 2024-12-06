def set_matches(word_arr, coords, matches)
  coords.each_with_index { |(y, x), idx| matches[y][x] = word_arr[idx] }
end

def matches_word?(word_arr, coords, matrix)
  word_arr.each_with_index.all? do |char, idx|
    char == matrix[coords[idx][0]][coords[idx][1]]
  end
end
