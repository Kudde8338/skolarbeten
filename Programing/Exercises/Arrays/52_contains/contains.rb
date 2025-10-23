def contains(array, value)
    i = 0
    while i < array.length
        if array[i] == value
            return true
        end
        i += 1
    end
    return false
end
