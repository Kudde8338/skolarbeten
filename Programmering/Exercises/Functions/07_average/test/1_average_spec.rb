require_relative 'spec_helper'

FUNCTION = 'average'
ARITY = 4
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

  it 'averages 4 positive integers' do
    average(1,2,3,4).must_equal 2.5
    average(4,3,2,1).must_equal 2.5
    average(10,20,40,30).must_equal 25
    average(1,13,37,5).must_equal 14
  end

  it 'averages with negative integers' do
    average(-1,-2,1,1).must_equal -0.25
    average(10,-20,40, -50).must_equal -5 
    average(-1,-2,-3,-4).must_equal -2.5 
  end


end
