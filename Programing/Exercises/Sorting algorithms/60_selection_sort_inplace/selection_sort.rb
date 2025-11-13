def selection_sort(array)
  n = array.length
  i = 0
  while i < n - 1
    min_index = i
    j = i + 1
    while j < n
      if array[j] < array[min_index]
        min_index = j
      end
      j += 1
    end


    if min_index != i
      temp = array[i]
      array[i] = array[min_index]
      array[min_index] = temp
    end
    i += 1
  end
  return array
end