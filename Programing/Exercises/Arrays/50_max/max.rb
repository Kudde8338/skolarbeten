def max(array)
    index = 0
    max = array[0]
    while index < array.length
        if array[index] > max
            max = array[index]
        end
        index += 1
    end
    return max
end
