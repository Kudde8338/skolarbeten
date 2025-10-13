require_relative 'spec_helper'

FUNCTION = 'cube'
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

  it 'returns 0 if input is 0' do
    cube(0).must_equal 0
  end

  it 'returns 1 if input is 1' do
    cube(1).must_equal 1
  end

  it 'returns 8 if input is 2' do
    cube(2).must_equal 8
  end

  it 'returns 74088 if input is 42' do
    cube(42).must_equal 74088
  end

  it 'returns -295408296 if input is -666' do
    cube(-666).must_equal -295408296
  end

  it 'works with random input' do
    random_input = rand(1..10_000)
    cube(random_input) == random_input ** 3
 end

end