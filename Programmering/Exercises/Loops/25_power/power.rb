#def multiply(num1, num2); product = 0; while 0 < num2; product += num1; num2 -= 1; end; return product; end; def power(num1, num2); product = 1; while num2 > 0; product = multiply(product, num1); num2 -= 1; end; return product; end;

def multiply(num1, num2)
    product = 0
    while 0 < num2
        product += num1
        num2 -= 1
    end
    return product
end

def power(num1, num2)
    product = 1
    while num2 > 0
        product = multiply(product, num1)
        num2-=1
    end
    return product
end

