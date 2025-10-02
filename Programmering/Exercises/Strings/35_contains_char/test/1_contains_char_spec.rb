require_relative 'spec_helper'

FUNCTION = 'contains_char'
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

  it 'returns the false if the string does not contain the supplied character' do
    StudentMethods.send(FUNCTION, "HellO", "b").must_equal false
    StudentMethods.send(FUNCTION, "hello", " ").must_equal false
  end

  it 'returns the true if the string does contain the supplied character' do
    StudentMethods.send(FUNCTION, "HellO", "O").must_equal true
    StudentMethods.send(FUNCTION, "hello", "h").must_equal true
  end

  it 'does not use the built in include? method' do
    String.any_instance.expects(:include?).never
    StudentMethods.send(FUNCTION, "hello\n", "e").must_equal true
  end

end