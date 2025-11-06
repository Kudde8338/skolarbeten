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