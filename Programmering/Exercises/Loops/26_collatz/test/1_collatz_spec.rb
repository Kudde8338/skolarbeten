require_relative 'spec_helper'

FUNCTION = 'collatz'
ARITY = 1
PATH = File.join(FUNCTION+".rb")
RELATIVE_PATH = File.join("..", PATH)

describe FUNCTION do
  
  def self.test_order
    :alpha
  end

  module StudentMethods; end

  def wrap_function_in_namespace
      StudentMethods.module_eval(File.read(PATH), __FILE__, __LINE__)
  end

  it 'exists' do
    assert File.exist?(PATH), "Du behöver skapa filen #{PATH}"
    require_relative RELATIVE_PATH
  end
  
  it "has a function named #{FUNCTION}" do
wrap_function_in_namespace
    assert(StudentMethods.instance_methods.include?(FUNCTION.to_sym),
               "Du behöver definera funktionen #{FUNCTION} i #{PATH}")  end
  
  it "takes #{ARITY.humanize} argument#{ARITY > 1 ? "s" : ""}" do
    message = "Funktionen #{FUNCTION} måste ta #{ARITY} argument"
    assert_equal ARITY  , method(FUNCTION.to_sym).arity, message
  end

  it 'returns the correct Collatz sequence length for various inputs' do
    test_cases = {
      1 => 1, 2 => 2, 3 => 8, 4 => 3, 5 => 6, 6 => 9, 7 => 17, 8 => 4,
      9 => 20, 10 => 7, 11 => 15, 12 => 10, 13 => 10, 14 => 18, 15 => 18,
      16 => 5, 17 => 13, 18 => 21, 19 => 21, 20 => 8, 21 => 8, 22 => 16,
      23 => 16, 24 => 11, 25 => 24, 26 => 11, 27 => 112, 28 => 19, 29 => 19,
      30 => 19, 31 => 107, 32 => 6, 33 => 27, 34 => 14, 35 => 14, 36 => 22,
      37 => 22, 38 => 22, 39 => 35, 40 => 9, 41 => 110, 42 => 9, 43 => 30,
      44 => 17, 45 => 17, 46 => 17, 47 => 105, 48 => 12, 49 => 25, 50 => 25,
      51 => 25, 52 => 12, 53 => 12, 54 => 113, 55 => 113, 56 => 20, 57 => 33,
      58 => 20, 59 => 33, 60 => 20, 61 => 20, 62 => 108, 63 => 108, 64 => 7,
      65 => 28, 66 => 28, 67 => 28, 68 => 15, 69 => 15, 70 => 15, 71 => 103,
      72 => 23, 73 => 116, 74 => 23, 75 => 15, 76 => 23, 77 => 23, 78 => 36
    }

    test_cases.each do |input, expected|
      result = collatz(input)
      _(result).must_equal expected, "input #{input} should give #{expected}, but gave #{result}"
    end
  end
end