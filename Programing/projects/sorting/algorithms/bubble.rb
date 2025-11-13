def bubble(array)
    swaps = 1
    while swaps > 0
        swaps = 0
        i = 0
        while i < array.length - 1
            if array[i] > array[i + 1]
                array[i], array[i + 1] = array[i + 1], array[i]
                swaps += 1
            end
            i += 1
        end
    end
    return array
end