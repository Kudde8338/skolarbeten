require_relative 'spec_helper'

FUNCTION = 'multiply'
ARITY = 2
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

  it 'returns 0 if both inputs are zero' do
    multiply(0, 0).must_equal 0
  end

  it 'returns 0 if first input is zero' do
    multiply(0, 1).must_equal 0
  end

  it 'returns 0 if second input is zero' do
    multiply(1, 0).must_equal 0
  end

  it 'returns 2 if first input is 2 and second input is 1' do
    multiply(2,1).must_equal 2
  end

  it 'returns 2 if first input is 1 and second input is 2' do
    multiply(1,2).must_equal 2
  end

  it 'returns the higher input if lower input is 1' do
    multiply(42,1).must_equal 42*1
    multiply(1,42).must_equal 1*42
  end

  it 'works with numerous inputs' do
    multiply(2,2).must_equal 2*2
    multiply(3,4).must_equal 3*4
    multiply(4,5).must_equal 4*5
    multiply(5,6).must_equal 5*6
    multiply(6,7).must_equal 6*7
    multiply(7,8).must_equal 7*8
    multiply(8,9).must_equal 8*9
    multiply(9,10).must_equal 9*10
    multiply(1337,1337).must_equal 1337*1337
    multiply(2096,4098).must_equal 2096*4098
  end

  it 'works with random inputs' do
    10.times do
      factor1 = rand(1..10_000)
      factor2 = rand(1..10_000)
      multiply(factor1, factor2).must_equal factor1 * factor2
    end
  end

  it 'does not use the * operator' do
    Integer.any_instance.expects(:*).never
    multiply(13,37).must_equal 481
  end
end