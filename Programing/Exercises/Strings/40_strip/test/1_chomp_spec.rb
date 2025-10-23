require_relative 'spec_helper'

FUNCTION = 'strip'
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

  it 'returns the string if the string has no whitespace' do
    StudentMethods.send(FUNCTION, "hello").must_equal "hello"
    StudentMethods.send(FUNCTION, "HellO").must_equal "HellO"
  end

  it 'removes whitespace from both ends of the string' do
    StudentMethods.send(FUNCTION, " hello ").must_equal "hello"
    StudentMethods.send(FUNCTION, "\nhello\n").must_equal "hello"
    StudentMethods.send(FUNCTION, "\t hello\t").must_equal "hello"
  end

  it 'removes multiple whitespace characters from both ends' do
    StudentMethods.send(FUNCTION, "  \t\nhello\n\t  ").must_equal "hello"
    StudentMethods.send(FUNCTION, "\t\nhell\no\t \n\t").must_equal "hell\no"
  end

  it 'does not remove whitespace in the middle of strings' do
    StudentMethods.send(FUNCTION, "\t hell\no").must_equal "hell\no"
    StudentMethods.send(FUNCTION, "hell\no \n").must_equal "hell\no"
  end

  it 'does not use the built in strip method' do
    String.any_instance.expects(:strip).never
    StudentMethods.send(FUNCTION, " hello ").must_equal "hello"
  end

end