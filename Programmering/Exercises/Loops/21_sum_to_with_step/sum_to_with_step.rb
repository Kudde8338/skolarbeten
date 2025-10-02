def sum_to_with_step(num, step)
    index = 0
    sum = 0
    while index <= num
        sum += index
        index += step
    end
    return sum
end