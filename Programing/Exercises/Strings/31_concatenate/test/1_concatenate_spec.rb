require_relative 'spec_helper'

FUNCTION = 'concatenate'
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

  it 'returns a new string consisting of the second string if the first string is empty' do
    StudentMethods.send(FUNCTION, "", "world").must_equal "world"
  end

  it 'returns a new string consisting of the first string if the second string is empty' do
    StudentMethods.send(FUNCTION, "hello", "").must_equal "hello"
  end

  it 'returns a new empty string if both strings are empty' do
    StudentMethods.send(FUNCTION, "", "").must_equal ""
  end

  it 'correctly concatenates and returns a new string when neither string is empty' do
    StudentMethods.send(FUNCTION, "hello", "world").must_equal "helloworld"
  end

  it 'does not modify either input string' do
    hello = "hello"
    world = "world"
    StudentMethods.send(FUNCTION, hello, world)
    hello.must_equal "hello"
    world.must_equal "world"
  end

    

end