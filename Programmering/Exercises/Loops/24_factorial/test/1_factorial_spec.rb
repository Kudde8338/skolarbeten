require_relative 'spec_helper'

FUNCTION = 'factorial'
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
    assert_equal ARITY, method(FUNCTION.to_sym).arity, message
  end

  it 'returns 1 if input is zero' do
    factorial(0).must_equal 1
  end

  it 'returns 1 if input is 1' do
    factorial(1).must_equal 1
  end

  it 'works for numerous inputs' do
    factorial(2).must_equal 2
    factorial(3).must_equal 6
    factorial(4).must_equal 24
    factorial(5).must_equal 120
    factorial(6).must_equal 720
    factorial(7).must_equal 5040
    factorial(8).must_equal 40320
    factorial(9).must_equal 362880
    factorial(10).must_equal 3628800
    factorial(20).must_equal 2432902008176640000
  end
end