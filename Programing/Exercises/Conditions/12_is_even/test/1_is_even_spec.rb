require_relative 'spec_helper'

FUNCTION = 'is_even'
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
  
  it 'returns true for input (8)' do
    is_even(8).must_equal true
  end

  it 'returns true for input (-248.0)' do
    is_even(-248).must_equal true
  end
  
  it 'returns false for input (4501)' do
    is_even(4501).must_equal false
  end

  it 'returns true for input (0)' do
    is_even(0).must_equal true
  end

end