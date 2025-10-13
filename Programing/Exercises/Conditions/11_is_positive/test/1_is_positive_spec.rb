require_relative 'spec_helper'

FUNCTION = 'is_positive'
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

  
  it 'returns true for positive numbers' do
    is_positive(783).must_equal true
    random_positive_number = rand(1..1000)
    is_positive(random_positive_number).must_equal true
  end
  
  it 'returns false for negative numbers' do
    is_positive(-3).must_equal false
    random_negative_number = rand(1..1000) * - 1
    is_positive(random_negative_number).must_equal false
  end

  it 'returns false for zero' do
    is_positive(0).must_equal false
  end

end