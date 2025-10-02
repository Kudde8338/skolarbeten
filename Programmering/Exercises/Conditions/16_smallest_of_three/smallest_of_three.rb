#def smallest_of_three(num1, num2, num3); return [num1, num2, num3].sort[0]; end
require_relative "../15_smallest_of_two/smallest_of_two.rb"

def smallest_of_three(num1, num2, num3)
    return smallest_of_two(smallest_of_two(num1, num2), num3)
end

p smallest_of_three(3,2,1)
p smallest_of_three(1,2,3)
p smallest_of_three(1,9, 5)