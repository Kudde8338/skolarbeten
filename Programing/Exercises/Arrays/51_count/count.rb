def count(array, item)
    index = 0
    count = 0
    while index < array.length
        if array[index] == item
            count += 1
        end
        index += 1
    end
    return count
end