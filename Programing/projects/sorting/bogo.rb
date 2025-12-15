def sorted(array)
    i = 0
    while i < array.length - 1
        if array[i] > array[i + 1]
            return false
        end
        i += 1
    end
    return true
end

def bogo(array)
  until sorted(array)
    array.shuffle!
    p array
  end
  return array
end

array = ((0..1000000).to_a + (0..1000000).to_a).shuffle

bogo(array)