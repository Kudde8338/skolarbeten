def insertion_sort(array)
  i = 1
  while i < array.length
    key = array[i]
    j = i - 1

    # Move elements greater than key one position ahead
    while j >= 0 && array[j] > key
      array[j + 1] = array[j]
      j -= 1
    end

    array[j + 1] = key
    i += 1
  end

  return array
end
