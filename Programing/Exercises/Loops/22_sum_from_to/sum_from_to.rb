def sum_from_to(num1, num2)
    if num1 < num2
        from = num1
        to = num2
    else
        from = num2
        to = num1
    end
    index = from
    sum = 0
    while index <= to
        sum += index
        index += 1
    end
    return sum
end