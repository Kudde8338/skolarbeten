def min(array)
    index = 0
    min = array[0]
    while index < array.length
        if array[index] < min
            min = array[index]
        end
        index += 1
    end
    return min
end
