require_relative 'spec_helper'

FUNCTION = 'smallest_of_two'
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
  
  it 'returns the smallest number when the smallest number is first)' do
    smallest_of_two(2,8).must_equal 2
  end

  it 'returns the smallest number when the smallest number is last)' do
    smallest_of_two(8,2).must_equal 2
  end
  
  it 'returns either number when both numbers are of equal size)' do
    smallest_of_two(2,2).must_equal 2
  end

  it 'works with negative numbers)' do
    smallest_of_two(-88,3).must_equal -88
  end

  it 'works with mix och integers and floats)' do
    smallest_of_two(-88.0,3).must_equal -88.0
  end

end