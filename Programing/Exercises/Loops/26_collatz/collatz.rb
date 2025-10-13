def collatz(num1)
    counter = 1
    while num1 != 1
        if num1 % 2 == 0
            num1 = num1/2
            counter += 1
        else
            num1 = (3 * num1) + 1
            counter += 1
        end
    end
    return counter
end