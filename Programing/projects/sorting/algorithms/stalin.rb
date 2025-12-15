def stalin(array)
  i = 0
  while i < array.length - 1
    if array[i] > array[i+1]
      array.delete_at(i+1)
    else
      i+=1
    end

  end
  return array
end

array = ((0..5).to_a + (0..5).to_a).shuffle
puts "Array: "
p array
p stalin(array)
puts ""