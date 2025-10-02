def factorial(num)
    index = 1
    product = 1
    while index <= num
        product *= index
        index += 1
    end
    return product
end
