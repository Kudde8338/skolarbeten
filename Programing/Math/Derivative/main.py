def f(x):
    return x**3 + 2*x + 5

def calculate_derivative(coord, precision):
    return (f(coord + precision) - f(coord)) / precision

print(calculate_derivative(4, 0.1))