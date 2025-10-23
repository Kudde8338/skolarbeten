require_relative 'spec_helper'

FUNCTION = 'first_element'
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

  it 'returnerar elementet "senap" till input ["senap", "ketchup", "varmkorv"]' do
    StudentMethods.send(FUNCTION, ["senap", "ketchup", "varmkorv"]).must_equal "senap"
  end

  it 'returnerar elementet [1,2,55,11] till input [[1,2,55,11], 0, 55]' do
    StudentMethods.send(FUNCTION, [[1,2,55,11], 0, 55]).must_equal [1,2,55,11]
  end

  it 'returnerar elementet nil till input [nil, 55, 788]' do
    StudentMethods.send(FUNCTION, [nil, 55, 788]).must_equal nil
  end

  it 'returnerar elementet nil om input är en tom array' do
    StudentMethods.send(FUNCTION, []).must_equal nil
  end

end