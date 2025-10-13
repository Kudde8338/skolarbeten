def count_even(num)
    index = 0
    even = 0
    while index <= num
        even += 1
        index += 2
    end
    return even
end

count_even(3)