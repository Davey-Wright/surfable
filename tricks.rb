# Arrays

  # Intersect - returns common values
    [1, 2, 3] & [1, 2]

  # return average values in array
  # https://stackoverflow.com/questions/1341271/how-do-i-create-an-average-from-a-ruby-array
    avg = [1, 2, 3, 4, 5]
    avg.inject{ |accumulator, el| accumulator + el }.to_f / avg.size
    # shorthand
    avg.inject(:+).to_f / avg.size

  # Sort array of hashes in decending order
    [{v: 1}, {v: 2}, {v: 3}].sort_by{ |w| w }.reverse!
