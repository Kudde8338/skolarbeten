def average(array)
    sum = 0
    i = 0
    len = array.length * 1.00
    while i < array.length
        sum += array[i]
        i += 1
    end
    return sum / len
end