require_relative 'spec_helper'

FUNCTION = 'contains_substring'
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

  it 'returns false if the string does not contain the supplied substring' do
    StudentMethods.send(FUNCTION, "HellO", "bye").must_equal false
    StudentMethods.send(FUNCTION, "hello", "world").must_equal false
  end

  it 'returns true if the string does contain the supplied substring' do
    StudentMethods.send(FUNCTION, "HellO", "ell").must_equal true
    StudentMethods.send(FUNCTION, "hello", "lo").must_equal true
  end

  it 'works with single character substrings' do
    StudentMethods.send(FUNCTION, "HellO", "O").must_equal true
    StudentMethods.send(FUNCTION, "hello", "h").must_equal true
    StudentMethods.send(FUNCTION, "hello", "z").must_equal false
  end

  it 'returns false for empty substring' do
    StudentMethods.send(FUNCTION, "hello", "").must_equal false
  end

  it 'returns false if substring is longer than string' do
    StudentMethods.send(FUNCTION, "hi", "hello").must_equal false
  end

  it 'does not use the built in include? method' do
    String.any_instance.expects(:include?).never
    StudentMethods.send(FUNCTION, "hello", "ell").must_equal true
  end

end