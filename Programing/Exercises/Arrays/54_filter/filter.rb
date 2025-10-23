def filter(array, value)
    newArray = []
    index = 0
    while index < array.length
        if array[index] == value
            newArray << array[index]
        end
        index += 1
    end
    return newArray
end